# Using Aruba+Cucumber to test cli app
## Prepare for cli app test using Aruba over Cucumber
1. Make Gemfile in project root:
```
    vi Gemfile
        source 'https://rubygems.org'
        gem 'aruba', '~> 2.0.0'
```
2. Install Aruba:
```
    gem install aruba
```
OR
```
    bundle install
```

3. Make executable script in project_root/tests:
```
    vi cucu.sh
        RUST_EXE="/target/debug"
        PATH=$PWD$RUST_EXE:$PATH
        cucumber
    chmod 755 test-cli.sh
```

## Test the app
1. Create cucumber test features in ./features
2. test:
```
    ./tests/cucu.sh
```
