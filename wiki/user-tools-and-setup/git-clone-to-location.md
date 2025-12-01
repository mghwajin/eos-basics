<!------------------------------------------->

# `git clone` to location

By default, **`git`** repositories are cloned into the **current** directory (usually `~/home`). You can specify the intended location for a repository using:

```shell
git clone <repository-url> <destination-folder>
```

- If this directory already exists, it must be **empty**, otherwise you will get an error.

- If this directory does **not** exist, creates a new directory at the specific path.

> [!TIP]
> 
> You can also clone a repository's **contents** into the **current directory** by using `git clone <repo-url> .`
>
> Since this clones all the content into the current location, it's important to `cd` into the correct directory first, lest files explode everywhere.  
> 
> See: [`cd` manpage](https://man.archlinux.org/man/cd.n), [`git`](https://git-scm.com/about)

<!------------------------------------------>

<!-- EOF -->
