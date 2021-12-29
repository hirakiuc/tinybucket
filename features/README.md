# features spec as a E2E test cases

This directory contains some features spec as E2E test cases.

Please be careful if you use these features spec, because these features spec files send actual API calls to bitbucket.

## Limitation

Currently, the features spec uses some static Bitbucket resources created by hirakiuc, only for this E2E testing purpose.
Due to this reason, other people can't use this `features` spec for now.

# HowToUse

```console
$ make features
```

## Requirements

2 Environment variables.

- `FEATURE_TEST_OAUTH_TOKEN`
- `FEATURE_TEST_OAUTH_SECRET`
