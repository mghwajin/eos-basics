## `git clone` to location

By default, **`git`** repositories are cloned into the **current** directory (usually `~/home`). You can specify the intended location for a repository using:

```bash
git clone <repository-url> <destination-folder>
```

- Clone into a **new** directory:

  ```bash
  git clone <https://github.com/myuser/example-repo.git> /desired/directory/path
  ```

- Clone into an **existing, empty** directory:

  ```bash
  git clone <repo-url> /existing/folder
  ```

- Clone the contents into the **current**, non-empty directory:

  ```bash
  git clone <repo-url> .
  ```

> [!NOTE] 
> Remember, this command clones the repository **contents** into the **current directory**. It is important to change into the appropriate working directory first with `cd`, lest files explode everywhere.
:::

> See [**`git`**](https://git-scm.com/about) | [**`git`** documentation](https://git-scm.com/docs/git) | [**`cd`** (manpage)](https://man.archlinux.org/man/cd.n)

---
