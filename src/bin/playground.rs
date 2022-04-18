use regex::Regex;

fn main() {
    env_logger::init();

    let mut r1 = "";
    let mut r2 = "";

    // ruby: /^(?<_range1>[[:alnum:]]+)\.\.(?<_range2>[[:alnum:]]+)/
    let re = Regex::new(r"^(?P<range_start>[0-9]+)\.\.(?P<range_end>[0-9]+)$").unwrap();
    let caps = re.captures("19..350");
    match caps {
        None => {
            log::debug!("NO regex found")
        }
        Some(caps) => {
            r1 = caps.name("range_start").unwrap().as_str();
            r2 = caps.name("range_end").unwrap().as_str();
            log::debug!("range_start: {:?}", &r1);
            log::debug!("  range_end: {:?}", &r2);
        }
    }

    let r1 = &r1.parse::<i32>().unwrap();
    let r2 = &r2.parse::<i32>().unwrap();
    let r = r1..=r2;
    let s = String::from("DSC_980323");
    let len = s.len();
    let i = &s[len - 3..len];
    if r.contains(&(&i.parse::<i32>().unwrap())) {
        println!(" i={} is inside range", i);
    }
    println!("r = {:?}", r);
}
