# 更多用法

## 服务管理

|  后缀  |     操作     | brew<br>services `bs` | pueue `pu` | espanso `es` | bitwarden `bw` |
| :----: | :----------: | :-------------------: | :--------: | :----------: | :------------: |
|  `*h`  |     help     |          ✅           |     ✅     |      ✅      |       ✅       |
| `*cf`  |    config    |          ✅           |            |              |       ✅       |
| `*df`  |     diff     |          ✅           |            |              |                |
| `*cl`  |    clean     |          ✅           |     ✅     |      ✅      |                |
| `*ls`  |     list     |          ✅           |            |      ✅      |       ✅       |
| `*st`  |    status    |                       |     ✅     |      ✅      |                |
|  `*s`  |    start     |          ✅           |     ✅     |      ✅      |                |
| `*rs`  |   restart    |          ✅           |     ✅     |      ✅      |                |
| `*pa`  |    pause     |          ✅           |     ✅     |              |                |
| `*upa` |   unpause    |          ✅           |            |              |                |
|  `*q`  | kill / stop  |          ✅           |     ✅     |      ✅      |                |
|  `*a`  | add / create |                       |     ✅     |      ✅      |       ✅       |
| `*rm`  |    remove    |          ✅           |     ✅     |              |       ✅       |
| `*ed`  |     edit     |                       |     ✅     |      ✅      |                |
| `*if`  |     info     |                       |            |      ✅      |                |
| `*rt`  |    reset     |                       |     ✅     |              |                |

### 容器

|  后缀  |     操作     | container `cic` | image `cti` |
| :----: | :----------: | :-------------: | :---------: |
|  `*h`  |     help     |       ✅        |     ✅      |
| `*df`  |     diff     |       ✅        |     ✅      |
| `*cl`  |    clean     |       ✅        |     ✅      |
| `*ls`  |     list     |       ✅        |     ✅      |
| `*st`  |    status    |       ✅        |             |
|  `*s`  |    start     |       ✅        |             |
| `*rs`  |   restart    |       ✅        |             |
| `*pa`  |    pause     |       ✅        |             |
| `*upa` |   unpause    |       ✅        |             |
| `*pa`  |    pause     |       ✅        |             |
|  `*q`  | kill / stop  |       ✅        |             |
|  `*a`  | add / create |       ✅        |             |
| `*rm`  |    remove    |       ✅        |     ✅      |
| `*if`  |     info     |       ✅        |     ✅      |
|  `*r`  |     run      |       ✅        |             |
| `*at`  |    attach    |       ✅        |             |
| `*ii`  |     init     |       ✅        |             |
| `*up`  |    update    |                 |     ✅      |
|  `*b`  |    build     |                 |     ✅      |
| `*sc`  |    search    |                 |     ✅      |
| `*pl`  |     pull     |                 |     ✅      |
| `*ps`  |     push     |                 |     ✅      |

## 系统管理

- `update`：更新系统
- `clean`：
  - [x] `clean`：清理垃圾
  - [x] `clean log`：清理日志
  - [x] `clean chrome`：清理 Chrome 缓存

### macOS

- `allow`：允许运行非官方来源 App

### Linux

## 工具管理

### Formats

- [x] `mdto`：转换 markdown
  - [x] 转换至含有 Unicode 的 PDF（中文）

```sh
mdto `文件名` `格式`
```
