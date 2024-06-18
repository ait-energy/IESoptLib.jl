# Releasing a new version

1. Add your content
2. Update the version in [Project.toml](./Project.toml)
3. Commit this using `chore: prep for vX.Y.Z`
4. Push (and create a MR/PR)
5. After everything is in `main`, comment on the commit in GitHub to trigger the registrator (see below)

```text
@JuliaRegistrator register
```

> Note: Make sure, that if you are adding (important) new functionality to ANY example that you follow this with a MINOR
> version bump. If you break ANY example, you need to increase the MAJOR version. Fixes, comments, refactors are fine in
> PATCH - but: New examples always should trigger a new MINOR version.
