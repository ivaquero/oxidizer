## Service Management

Oxidizer's task & service management follows the same philosophy of package management, _i.e._ to provide unified interfaces to facilitate workflows.

|        |    Action    | brew<br>services `bs` | pueue `pu` | espanso `es` | bitwarden `bw` |
| :----: | :----------: | :-------------------: | :--------: | :----------: | :------------: |
|  `*h`  |     help     |          ✅           |     ✅     |      ✅      |       ✅       |
| `*cf`  |     help     |          ✅           |            |              |       ✅       |
| `*df`  |     diff     |          ✅           |            |              |                |
| `*cl`  |    clean     |          ✅           |     ✅     |      ✅      |                |
| `*ls`  |     list     |          ✅           |            |      ✅      |       ✅       |
| `*st`  |    status    |                       |     ✅     |      ✅      |                |
|  `*s`  |    start     |          ✅           |     ✅     |      ✅      |                |
| `*rs`  |   restart    |          ✅           |     ✅     |      ✅      |                |
| `*pa`  |    pause     |          ✅           |     ✅     |              |                |
| `*upa` |   unpause    |          ✅           |            |              |                |
| `*pa`  |    pause     |          ✅           |     ✅     |              |                |
|  `*q`  | kill / stop  |          ✅           |     ✅     |      ✅      |                |
| `*rt`  |    reset     |                       |     ✅     |              |                |
|  `*a`  | add / create |                       |     ✅     |      ✅      |       ✅       |
| `*rm`  |    remove    |          ✅           |     ✅     |              |       ✅       |
|  `*e`  |     edit     |                       |     ✅     |      ✅      |                |
| `*if`  |     info     |                       |            |      ✅      |                |
|  `*r`  |     run      |                       |            |              |                |
| `*at`  |    attach    |                       |            |              |                |

### Containers

|        |    Action    | docker<br>container `dc` | podman<br>container `pc` |
| :----: | :----------: | :----------------------: | :----------------------: |
|  `*h`  |     help     |            ✅            |            ✅            |
| `*df`  |     diff     |            ✅            |
| `*cl`  |    clean     |            ✅            |
| `*ls`  |     list     |            ✅            |
| `*st`  |    status    |            ✅            |            ✅            |
|  `*s`  |    start     |            ✅            |            ✅            |
| `*rs`  |   restart    |            ✅            |            ✅            |
| `*pa`  |    pause     |            ✅            |
| `*upa` |   unpause    |            ✅            |
| `*pa`  |    pause     |            ✅            |
|  `*q`  | kill / stop  |            ✅            |            ✅            |
| `*rt`  |    reset     |                          |
|  `*a`  | add / create |            ✅            |            ✅            |
| `*rm`  |    remove    |            ✅            |
|  `*e`  |     edit     |                          |                          |
| `*if`  |     info     |            ✅            |
|  `*r`  |     run      |            ✅            |            ✅            |
| `*at`  |    attach    |            ✅            |            ✅            |

### Images

|       | Action | docker<br>image `di` | podman<br>image `pi` |
| :---: | :----: | :------------------: | :------------------: |
| `*h`  |  help  |                      |                      |
| `*ii` |  init  |                      |                      |
| `*df` |  diff  |                      |          ✅          |
| `*cl` | clean  |                      |          ✅          |
| `*ls` |  list  |          ✅          |          ✅          |
| `*st` | status |                      |                      |
| `*a`  |  add   |                      |                      |
| `*rm` | remove |          ✅          |          ✅          |
| `*pl` |  pull  |          ✅          |          ✅          |
| `*ps` |  push  |          ✅          |          ✅          |
| `*cf` | config |                      |                      |
