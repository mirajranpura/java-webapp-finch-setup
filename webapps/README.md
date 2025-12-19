# WAR Files Directory

Place your Java WAR files in this directory before building the container.

## Example Structure

```
webapps/
├── ROOT.war          # Main application (accessible at /)
├── LIVE.war          # Live application (accessible at /LIVE)
├── images.war        # Images service (accessible at /images)
└── smvs.war          # SMVS application (accessible at /smvs)
```

## Important Notes

- **ROOT.war** will be deployed as the root application (accessible at `/`)
- Other WAR files will be accessible at `/{filename}` (without the .war extension)
- Make sure your WAR files are properly built and tested before deployment
- The Dockerfile will copy all `*.war` files from this directory to Tomcat's webapps folder

## WAR File Requirements

- Valid Java WAR (Web Application Archive) files
- Compatible with Tomcat 9.0 and Java 8
- Properly configured web.xml if needed