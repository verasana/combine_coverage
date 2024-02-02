# Example
*Note: We recommend [melos](https://melos.invertase.dev/) to manage the execution of these steps in large monorepos.*

If we have multiple Dart and Flutter packages in a monorepo and want to generate a single, shared `lcov.info` file to represent all coverage, we can follow these steps:

## 1. Run unit tests with the `--coverage` flag
In each Flutter package, run: 
```
flutter test --coverage
```

In each Dart package, run:
```
dart test --coverage=./coverage
```

## 2. Convert test coverage output for Dart packages to lcov format
By default, Dart outputs `json` coverage reports, but we can use the [coverage](https://pub.dev/packages/coverage) package to format the Dart test coverage output in `lcov` format. In each Dart package run...

```
dart pub global run coverage:format_coverage --in="./coverage/test" --out="./coverage/lcov.info" --lcov --report-on="./lib"
```

## 3. Combine the coverage reports
Now that we have an `lcov` file in each package in our monorepo, we just need to run `combine_coverage`. If you have [added dart scripts to your PATH](https://dart.dev/tools/pub/cmd/pub-global#running-a-script-from-your-path) use the following:

```
combine_coverage --repo-path="<path-to-your-monorepo>"
```

Otherwise, [you can use the following](https://dart.dev/tools/pub/cmd/pub-global#running-a-script-using-pub-global-run):

```
dart pub global run combine_coverage --repo-path="<path-to-your-monorepo>"
```

In the monorepo's root there will now be a file at `coverage/lcov.info` that combines the coverage output for all packages with corrected file paths. This file can be passed to any visualization tool to make a full and accurate coverage report.

If you'd like to specify a directory to place the combined lcov file, use the `--output-directory` flag.