## Service Management

oxidizer's task & service management follows the same philosophy of package management, _i.e._ to provide unified interfaces to facilitate workflows.

| Suffix |    Action    | brew<br>services `bs` | espanso `es` | bitwarden `bw` |
| :----: | :----------: | :-------------------: | :----------: | :------------: |
|  `*h`  |     help     |           ✅           |      ✅       |       ✅        |
| `*cf`  |    config    |           ✅           |              |       ✅        |
| `*df`  |     diff     |           ✅           |              |                |
| `*cl`  |    clean     |           ✅           |      ✅       |                |
| `*ls`  |     list     |           ✅           |      ✅       |       ✅        |
| `*st`  |    status    |                       |      ✅       |                |
|  `*s`  |    start     |           ✅           |      ✅       |                |
| `*rs`  |   restart    |           ✅           |      ✅       |                |
| `*pa`  |    pause     |           ✅           |              |                |
| `*upa` |   unpause    |           ✅           |              |                |
|  `*q`  | kill / stop  |           ✅           |      ✅       |                |
|  `*a`  | add / create |                       |      ✅       |       ✅        |
| `*rm`  |    remove    |           ✅           |              |       ✅        |
| `*ed`  |     edit     |                       |      ✅       |                |
| `*if`  |     info     |                       |      ✅       |                |
| `*rt`  |    reset     |                       |              |                |

### Containers

| Suffix |    Action    | container `cic` | image `cti` |
| :----: | :----------: | :-------------: | :---------: |
|  `*h`  |     help     |        ✅        |      ✅      |
| `*df`  |     diff     |        ✅        |      ✅      |
| `*cl`  |    clean     |        ✅        |      ✅      |
| `*ls`  |     list     |        ✅        |      ✅      |
| `*st`  |    status    |        ✅        |             |
|  `*s`  |    start     |        ✅        |             |
| `*rs`  |   restart    |        ✅        |             |
| `*pa`  |    pause     |        ✅        |             |
| `*upa` |   unpause    |        ✅        |             |
| `*pa`  |    pause     |        ✅        |             |
|  `*q`  | kill / stop  |        ✅        |             |
|  `*a`  | add / create |        ✅        |             |
| `*rm`  |    remove    |        ✅        |      ✅      |
| `*if`  |     info     |        ✅        |      ✅      |
|  `*r`  |     run      |        ✅        |             |
| `*at`  |    attach    |        ✅        |             |
| `*ii`  |     init     |        ✅        |             |
| `*up`  |    update    |                 |      ✅      |
|  `*b`  |    build     |                 |      ✅      |
| `*sc`  |    search    |                 |      ✅      |
| `*pl`  |     pull     |                 |      ✅      |
| `*ps`  |     push     |                 |      ✅      |
