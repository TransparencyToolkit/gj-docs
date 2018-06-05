These are instructions for setting up https://usavwl.couragefound.org/

1. Setup LookingGlass and DocManager instances by following steps 1-5 at
https://github.com/TransparencyToolkit/Test-Data/blob/master/getting_started.md.

2. Download and unzip https://transparencytoolkit.org/gj-docs.zip
Some of the documents are too big for Github, so this has a more complete set
than this repository. To avoid needing to adjust paths in the script, unzip
this at ../gj-docs (directory above this one)

3. cp setup/version_fields.json to DocManager/dataspec_files/fields_for_all_sources/version_fields.json
This hides a field that isn't needed for this instance

4. Start DocManager

5. In the setup/ directory, run: ruby usvwl_index_script.rb.
If DocManager is running somewhere other than localhost:3000, the path for
this may need to be adjusted.

6. In LookingGlass/config/initializers/project_config.rb, change the
PROJECT_CONFIG environment variable to "free_press_legal". Then, start LookingGlass.
