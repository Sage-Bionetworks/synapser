# synGetProjectSetting

Gets the ProjectSetting for a project.

## Usage

``` r
synGetProjectSetting(project, setting_type)
```

## Arguments

- project:

  Project entity or its id as a string  

- setting_type:

  type of setting. Choose from: 'upload', 'external_sync',
  'requester_pays'

## Value

The ProjectSetting as a named list or NULL if no settings of the
specified type exist.
