## Project Management

|       | Action | git `g` | git tag `gt` | cmake `cm` |
| :---: | :----: | :-----: | :----------: | :--------: |
| `*h`  |  help  |   ✅    |      ✅      |     ✅     |
| `*ii` |  init  |   ✅    |              |            |
| `*df` |  diff  |   ✅    |              |            |
| `*cl` | clean  |   ✅    |      ✅      |            |
| `*ls` |  list  |         |      ✅      |            |
| `*st` | status |   ✅    |              |            |
| `*a`  |  add   |   ✅    |      ✅      |            |
| `*rm` | remove |         |      ✅      |            |
| `*pl` |  pull  |   ✅    |              |            |
| `*ps` |  push  |   ✅    |              |            |
| `*cf` | config |   ✅    |              |            |

### Git

- [x] delete ignored files in `.gitignore`: `gcl --ig`
- [x] find fat blob files: `gjk`
- [x] integration of `git filter-repo` command
  - [x] clean files by size bigger than `git filter-size`
  - [x] clean files by id `git filter-id`
  - [x] clean files by path `git filter-path`
