# Conventions
### What is a project ? 
```text
a project is a repo of code, a project is a one to one with repo 
```

### types of projects ? 
```text
projects can be packages which used into other project, application level project which building and managing binaries because an application project doesn't have to manage one binary
```

### about go.mod ? 
```text
your project cannot maintain more than one go.mod file in the entire project, even if you have folders that contains another go.mod in addition to the root one, this will cause a lot of errors
```

### about golang environment .. 
- if we run `go env` we will got a lot of paths :- <br>
    - we can find the source code of all the dependencies we installed before on this path 
    ```cmd
    GOMODCACHE=C:\Users\gamil\go\pkg\mod
    ```

    - when we run `go mod tidy` to download the dependencies we need, this is gonna happen: 
