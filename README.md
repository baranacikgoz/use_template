# Use Template

Allows you to use any Flutter & Dart project as a template with a single line command.  
It basically clones/copies the project and than changes all imports and platform specific names.

| Android            | iOS                | Linux              | macOS              | Windows            | Web                |
| ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ |
| :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |

## Installation
Open terminal and type the following code.
````
> dart pub global activate use_template
````

## Usage
You are asked for three parameters.  

* New name:
  * This will be the new name of your application.
* Template:
  * You can provide a git repository address containing the template project or a directory from your computer.
* Directory to install template:
  * Provide a directory to install.

### 1. One line code usage
##### With a template from a git repository
````
> use_template my_new_application https://github.com/baranacikgoz/BloC_repository_pattern_template C:\Users\baran\Software\
````
##### With a template from your computer
````
> use_template my_new_application C:\path_to_template\flutter_template_app C:\Users\baran\Software\
````
### 2. Interactive usage
You can use interactive interface by passing no arguments.

````
> use_template
````
![1](https://user-images.githubusercontent.com/52239507/181810321-cad98c35-d712-4f3a-bef4-bafd0b4a3636.png)  

![2](https://user-images.githubusercontent.com/52239507/181810387-20af325c-cf43-4c7a-9fd6-5cd1c85a597c.png)  

![3](https://user-images.githubusercontent.com/52239507/181811697-1686cd8c-1e0d-4226-8f12-1e6a896cc90f.png)  

![4](https://user-images.githubusercontent.com/52239507/181810989-16982e90-4ce0-4231-bd86-393f1ddbab17.png)  
