fn main() {
    let r1 = 123;
    let r2 = r1 - 10;
    let r = r1..=r2;
    let i = "120";
    if r.contains(&i.parse::<i32>().unwrap()) {
        println!(" i={} is inside range", i);
    }

    println!("r = {:?}", r);
}
