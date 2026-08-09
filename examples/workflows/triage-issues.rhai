let meta = #{
    name: "triage-issues",
    description: "Triage a set of issue titles in parallel, then verify the top priorities",
    when_to_use: "When you have many issue titles or bug reports to rank and check",
    phases: [
        #{ title: "Triage", detail: "classify and prioritize each issue" },
        #{ title: "Verify", detail: "skeptic check on top priorities" },
        #{ title: "Report", detail: "single ranked report" },
    ],
};

let triage_schema = #{
    "type": "object",
    "required": ["priority", "area", "summary", "next_action"],
    "properties": #{
        "priority": #{ "type": "string" },
        "area": #{ "type": "string" },
        "summary": #{ "type": "string" },
        "next_action": #{ "type": "string" },
    },
};

let verdict_schema = #{
    "type": "object",
    "required": ["keep", "reason"],
    "properties": #{
        "keep": #{ "type": "boolean" },
        "reason": #{ "type": "string" },
    },
};

let root = if args == () { () } else { args.root };
let issues = if args == () { () } else { args.issues };
if root == () { pause("verification", "Pass args.root — project path or '.' "); }
if issues == () { pause("verification", "Pass args.issues — array of issue title strings"); }

phase("Triage");
let jobs = [];
let i = 0;
for title in issues {
    let p = "You are triaging software issues for the repo at " + root + ". ";
    p += "Issue title: " + title + ". ";
    p += "Use read-only tools (list_dir, grep, read_file) to ground the area in real paths when possible. ";
    p += "Do not invent files. priority must be one of: P0, P1, P2, P3. ";
    p += "Return only the schema fields.";
    jobs.push(#{
        prompt: p,
        label: "triage-" + i.to_string(),
        capability_mode: "read-only",
        output_schema: triage_schema,
    });
    i += 1;
}
let results = parallel(jobs);

let ranked = [];
let idx = 0;
for r in results {
    if r != () && r.success && r.output != () {
        ranked.push(#{
            title: issues[idx],
            priority: r.output.priority,
            area: r.output.area,
            summary: r.output.summary,
            next_action: r.output.next_action,
        });
    }
    idx += 1;
}
if ranked.len() == 0 {
    complete(#{ summary: "No triage results.", items: [] });
}

phase("Verify");
let top = [];
let j = 0;
while j < ranked.len() && top.len() < 5 {
    let pr = ranked[j].priority;
    if pr == "P0" || pr == "P1" {
        top.push(ranked[j]);
    }
    j += 1;
}
if top.len() == 0 {
    // take first three if nothing marked P0/P1
    let k = 0;
    while k < ranked.len() && top.len() < 3 {
        top.push(ranked[k]);
        k += 1;
    }
}

let vjobs = [];
for item in top {
    let vp = "Adversarially verify this triage. Title: " + item.title + ". ";
    vp += "Claimed priority: " + item.priority + ". Area: " + item.area + ". ";
    vp += "Summary: " + item.summary + ". ";
    vp += "Keep=true only if the priority is justified by the title and any repo evidence you can read under " + root + ". ";
    vp += "Default keep=false when unsure.";
    vjobs.push(#{
        prompt: vp,
        label: "verify:" + item.title,
        capability_mode: "read-only",
        output_schema: verdict_schema,
    });
}
let verdicts = parallel(vjobs);

let confirmed = [];
let vi = 0;
for v in verdicts {
    if v != () && v.success && v.output.keep == true {
        confirmed.push(top[vi]);
    }
    vi += 1;
}

phase("Report");
let report = "# Issue triage report\n\n";
report += "Confirmed high priorities: " + confirmed.len().to_string() + "\n\n";
for c in confirmed {
    report += "- **" + c.priority + "** " + c.title + " — " + c.summary + " → " + c.next_action + "\n";
}
report += "\n## All triage rows\n\n";
for row in ranked {
    report += "- " + row.priority + " | " + row.title + " | " + row.area + "\n";
}
let path = write_scratch_file("triage-report.md", report);
log("triage complete: " + confirmed.len().to_string() + " confirmed of " + ranked.len().to_string());
complete(#{ summary: confirmed.len().to_string() + " confirmed priorities", path: path, items: confirmed });
