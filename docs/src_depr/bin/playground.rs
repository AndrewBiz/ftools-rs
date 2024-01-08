use regex::Regex;

fn main() {
    env_logger::init();

    let r1;
    let r2;

    // ruby: /^(?<_range1>[[:alnum:]]+)\.\.(?<_range2>[[:alnum:]]+)/
    let re = Regex::new(r"^(?P<range_start>[0-9]+)\.\.(?P<range_end>[0-9]+)$").unwrap();
    if let Some(caps) = re.captures("019..23") {
        r1 = caps
            .name("range_start")
            .unwrap()
            .as_str()
            .parse::<i32>()
            .unwrap();
        r2 = caps
            .name("range_end")
            .unwrap()
            .as_str()
            .parse::<i32>()
            .unwrap();
        log::debug!("range_start: {:?}", &r1);
        log::debug!("  range_end: {:?}", &r2);
    } else {
        r1 = 0;
        r2 = 0;
        log::debug!("NO regex found");
    }
    let r = r1..=r2;
    let rlen = r2.to_string().len();
    let s = String::from("DSC_980323");
    let slen = s.len();
    let i = &s[slen - rlen..slen];
    println!("r = {:?}", r);
    if r.contains(&i.parse::<i32>().unwrap()) {
        println!(" i={} is inside range", i);
    } else {
        println!(" i={} is out of range", i)
    }
}
