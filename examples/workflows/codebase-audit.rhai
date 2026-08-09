let meta = #{
    name: "codebase-audit",
    description: "Parallel read-only audit across security, reliability, and maintainability with adversarial verification",
    when_to_use: "When you want a bounded multi-lens audit of a directory tree",
    phases: [
        #{ title: "Scan", detail: "specialist reviewers in parallel" },
        #{ title: "Verify", detail: "independent skeptics per finding" },
        #{ title: "Report", detail: "verified findings only" },
    ],
};

let findings_schema = #{
    "type": "object",
    "required": ["findings"],
    "properties": #{
        "findings": #{
            "type": "array",
            "maxItems": 8,
            "items": #{
                "type": "object",
                "required": ["file", "issue", "lens"],
                "properties": #{
                    "file": #{ "type": "string" },
                    "issue": #{ "type": "string" },
                    "lens": #{ "type": "string" },
                },
            },
        },
    },
};

let verdict_schema = #{
    "type": "object",
    "required": ["real", "reason", "evidence"],
    "properties": #{
        "real": #{ "type": "boolean" },
        "reason": #{ "type": "string" },
        "evidence": #{ "type": "string" },
    },
};

let root = if args == () { () } else { args.root };
if root == () { pause("verification", "Pass args.root — directory to audit (e.g. crates or src)"); }

let lenses = [
    "security (auth, injection, secrets, unsafe shell)",
    "reliability (error handling, retries, resource leaks)",
    "maintainability (dead code hotspots, unclear modules, missing tests)",
];

phase("Scan");
let jobs = [];
for lens in lenses {
    let p = "Audit the tree under " + root + " for " + lens + ". ";
    p += "Use only read-only tools (read_file, grep, list_dir, read-only git). ";
    p += "Do not answer from memory — open real files. ";
    p += "Report at most 8 findings as {file, issue, lens}. ";
    p += "Empty findings is valid only after you searched. Set lens to a short label for this dimension.";
    jobs.push(#{
        prompt: p,
        label: "scan:" + lens,
        capability_mode: "read-only",
        output_schema: findings_schema,
    });
}
let results = parallel(jobs);

let findings = [];
for r in results {
    if r != () && r.success && r.output.findings != () {
        for f in r.output.findings {
            findings.push(f);
        }
    }
}
if findings.len() == 0 {
    complete(#{ summary: "No findings after scan.", confirmed: [] });
}

// Cap verification fan-out
let capped = [];
let ci = 0;
while ci < findings.len() && capped.len() < 16 {
    capped.push(findings[ci]);
    ci += 1;
}
if findings.len() > capped.len() {
    log("truncated findings for verify: kept " + capped.len().to_string() + " of " + findings.len().to_string());
}

phase("Verify");
let vjobs = [];
for f in capped {
    let vp = "Adversarially verify this audit finding by reading the shipped code. ";
    vp += "Finding: \"" + f.issue + "\" in " + f.file + " (lens: " + f.lens + "). ";
    vp += "Set real=true only with concrete evidence you independently inspected. ";
    vp += "Otherwise real=false. evidence must quote a path or symbol.";
    vjobs.push(#{
        prompt: vp,
        label: "verify:" + f.file,
        capability_mode: "read-only",
        output_schema: verdict_schema,
    });
}
let verdicts = parallel(vjobs);

let confirmed = [];
let vi = 0;
for v in verdicts {
    if v != () && v.success && v.output.real == true
        && v.output.evidence != () && v.output.evidence != "" {
        confirmed.push(#{
            file: capped[vi].file,
            issue: capped[vi].issue,
            lens: capped[vi].lens,
            evidence: v.output.evidence,
        });
    }
    vi += 1;
}

phase("Report");
let report = "# Codebase audit (verified findings only)\n\n";
report += "Survived verification: " + confirmed.len().to_string() + " / " + capped.len().to_string() + "\n\n";
for c in confirmed {
    report += "## " + c.lens + " — `" + c.file + "`\n";
    report += "- Issue: " + c.issue + "\n";
    report += "- Evidence: " + c.evidence + "\n\n";
}
if confirmed.len() == 0 {
    report += "_No findings survived independent verification._\n";
}
let path = write_scratch_file("audit-report.md", report);
log(confirmed.len().to_string() + " verified findings");
complete(#{ summary: confirmed.len().to_string() + " verified findings", path: path, confirmed: confirmed });
