# Testing

## How to run the test suite

Run the entire models test suite:

```
bundle exec rake test:models
```

Run a single model test collection in the models test suite:

```
ruby -I"test/test_helper:./test" test/models/my_model_test.rb
```
		
Run a single test from a test collection:
		
```
ruby -I"test/test_helper:./test" test/models/my_model_test.rb -n test_name_of_test
```

