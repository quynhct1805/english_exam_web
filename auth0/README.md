Auth0 Service
===================

This module provides definition files for setting up Auth0.

### Update development Auth0 tenant:

```bash
$ npm ci
$ npx a0deploy import -c dev-config.json -i tenant.yaml
```

### Update production Auth0 tenant:

1. Copy **dev-config.json** to **config.prod.json**
2. Replace values in config.prod.json with data from production tenant.
3. `npx a0deploy import -c config.prod.json -i tenant.yaml`
