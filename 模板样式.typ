// 阜阳师范大学本科毕业论文（设计）· 理工类；从用户提供的 Typst 项目重构。
// 所有排版规则集中于本文件；主文档只调用本模板并按顺序引入内容。
//
// ================= 学校格式规范对照（依据《阜阳师范大学毕业论文（设计）参考模板·理工类》） =================
//   纸张与页边距：A4；封面 上2.5cm/下2.5cm/左3cm/右2.5cm，正文 上2.5cm/下2cm/左2.5cm/右2cm。
//   字体与字号：正文 宋体小四(12pt)；西文 Times New Roman；摘要 宋体五号(10.5pt)；
//              封面标题 黑体小初(36pt)；一级标题 宋体小四(12pt)加粗；
//              二级、三级、四级标题 宋体小四(12pt)、不加粗。
//   行距：正文 固定 20pt（≈1.5 倍小四行距）；摘要 16pt；承诺 35pt。
//   段落：首行缩进 2 字符；正文两端对齐。
//   标题层级：一级 = 二级 == 三级 === 四级 ====，编号 1 / 1.1 / 1.1.1 / 1.1.1.1。
//   页码：封面与诚信承诺无页码；摘要、目录用 I/II/III；第一章起从 1 重新计数，置于页面底部居中。
//   图表：图题在图下方、表题在表上方，全文连续编号（图 1、表 1）；
//         表内文字 宋体五号，表头黑体五号。
//   公式：全文连续编号（1）（2）……，右端齐。
//   参考文献：采用 GB/T 7714—2015 顺序编码制，正文上标引用 [1][2]……；
//             文献条目 宋体五号(10.5pt)、行距 16pt。
// ======================================================================================================
#import "论文信息.typ": 信息

// ---------- 集中参数：字体、字号、页边距、行距 ----------
#let 字体方案 = sys.inputs.at("font-mode", default: "windows") // Windows 默认；通用字体使用 "portable"。
#let 西文 = if 字体方案 == "portable" { "TeX Gyre Termes" } else { "Times New Roman" }
#let 宋体 = (西文, if 字体方案 == "portable" { "FandolSong" } else { "SimSun" })
#let 黑体 = (西文, if 字体方案 == "portable" { "FandolHei" } else { "SimHei" })
#let 仿宋 = if 字体方案 == "portable" { (西文, "FandolFang R") } else { (西文, "仿宋_GB2312", "FangSong") }
#let 楷体 = (西文, if 字体方案 == "portable" { "FandolKai" } else { "KaiTi" })
#let 小初 = 36pt; #let 小二 = 18pt; #let 三号 = 16pt; #let 四号 = 14pt; #let 小四 = 12pt; #let 五号 = 10.5pt
#let 正文边距 = (top: 2.5cm, bottom: 3cm, left: 2.5cm, right: 2cm)
#let 封面边距 = (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2.5cm)
#let 正文行距 = 20pt; #let 摘要行距 = 16pt; #let 承诺行距 = 35pt
#let 校徽路径 = "Figure/图标.png"; #let 参考文献样式 = "gb-t-7714-2015-numeric.csl"
#let 正文开始 = state("fynu-body-started", false)
#let 摘要开始 = state("fynu-front-started", false)
#let 标题类型 = state("fynu-heading-variant", "chapter")
#let 页脚 = context align(center, text(font: 宋体, size: 五号, counter(page).display()))
#let 正文起始() = context {
  if not 正文开始.get() { counter(page).update(1); 正文开始.update(true) }
}
#let 前置起始() = context {
  if not 摘要开始.get() { counter(page).update(1); 摘要开始.update(true) }
}
#let 正文() = [#pagebreak(weak: true)#正文起始()]
#let 前置标题(内容) = align(center, block(above: 0pt, below: 6pt,
  text(font: 黑体, size: 四号, weight: "bold", 内容)))

// ---------- 主模板：只提供样式，不自动插入封面、摘要等内容 ----------
#let fynu-thesis(body) = {
  set document(title: 信息.title, author: 信息.author.text)
  set text(font: 宋体, size: 小四, lang: "zh", region: "cn", top-edge: 1em, bottom-edge: 0em)
  set par(justify: true, first-line-indent: (amount: 2em, all: true), leading: 正文行距 - 小四, spacing: 0pt)
  set page(paper: "a4", margin: 正文边距, header: none, numbering: "1", footer: 页脚, footer-descent: 0.3cm)
  set heading(numbering: "1.1", outlined: true)
  show heading: it => context {
    if it.level == 1 { pagebreak(weak: true); 正文起始() }
    let 特殊 = it.numbering == none
    // 所有正文标题均为宋体小四；一级仅使用细描边模拟宋体加粗，二级及以下不加粗。
    let 标题字体 = 宋体
    let 标题字号 = 小四
    let 字重 = "regular" // 一级标题仅用描边模拟加粗，避免西文数字粗体叠加描边
    let 对齐 = if 特殊 and 标题类型.get() == "ack" { center } else { left }
    let 编号 = if 特殊 { [] } else { [#counter(heading).display(it.numbering)#h(1em)] }
    set par(first-line-indent: 0pt, justify: false, leading: 正文行距 - 标题字号, spacing: 0pt)
    align(对齐, block(width: 100%, sticky: true, above: if it.level == 1 { 0pt } else { 10pt }, below: 6pt,
      text(font: 标题字体, size: 标题字号, weight: 字重, stroke: if it.level == 1 { 0.0285em } else { none })[#编号#it.body]))
  }
  set figure(numbering: "1")
  set figure.caption(separator: "：")
  show figure.where(kind: image): set figure(supplement: [图])
  show figure.where(kind: table): set figure(supplement: [表])
  show figure.where(kind: table): set figure.caption(position: top)
  show figure: it => block(above: 12pt, below: 12pt, it)
  // 图注：宋体五号；表注：仿宋GB2312（缺失时回退FangSong）小四；英文数字Times New Roman，均不加粗。
  show figure.caption: it => {
    let 表注 = it.kind == table
    let 注字体 = if 表注 { if 字体方案 == "portable" { (西文, "FandolFang R") } else { ((name: 西文, covers: "latin-in-cjk"), "仿宋_GB2312", "FangSong") } } else { 宋体 }
    let 注字号 = if 表注 { 小四 } else { 五号 }
    set text(font: 注字体, size: 注字号, weight: 400, stroke: none)
    set par(first-line-indent: 0pt, leading: (if 表注 { 正文行距 } else { 摘要行距 }) - 注字号, spacing: 0pt)
    set strong(delta: 0)
    show strong: it => it.body
    show regex("[A-Za-z0-9]+"): set text(font: 西文, weight: 400, stroke: none)
    align(center, [#it.supplement#text(fill: rgb("#0000ff"), weight: 400, stroke: none)[#it.counter.display(it.numbering)]#it.separator#it.body])
  }
  
  set table(inset: (x: 6pt, y: 5pt))
  show table: it => {
    set text(font: 宋体, size: 五号)
    set par(first-line-indent: 0pt, leading: 摘要行距 - 五号, spacing: 0pt)
    it
  }
  
set math.equation(numbering: (..nums) => text(font: 西文, size: 小四, weight: "regular", stroke: none, numbering("(1)", ..nums)), supplement: [式])

  show math.equation.where(block: true): set block(above: 10pt, below: 10pt)
  show ref: it => {
  let el = it.element
  if el == none {
    it
  } else if el.func() == math.equation {
    link(el.location())[式 (#numbering("1", ..counter(math.equation).at(el.location())))]
  } else if el.func() == figure {
    let prefix = el.supplement
    let num = numbering(el.numbering, ..counter(figure.where(kind: el.kind)).at(el.location()))
    link(el.location())[#prefix#h(.25em)#text(fill: rgb("#0000ff"), weight: "regular", stroke: none)[#num]]
  } else {
    it
  }
}
  set bibliography(style: 参考文献样式, title: none)
  show bibliography: it => {
    heading(level: 1, numbering: none)[参考文献]
    set text(font: 宋体, size: 五号)
    set par(first-line-indent: 0pt, justify: true, leading: 摘要行距 - 五号, spacing: 0pt)
    show grid.cell.where(x: 0): cell => align(left, cell)
    it
  }
  body
}

// ---------- 封面：只保留版式，所有需要填写的内容由“Chaper/封面.typ”通过参数传入 ----------
// 字段约定：推荐填字符串（自动排为一行或多行）；也兼容数组 ([第一行], [第二行]) 手动分行。

// 封面自动排版：字符串自动测宽分行；原来的内容数组仍支持手动分行。
#let 封面文字(内容) = {
  show regex("[A-Za-z0-9]+(?:[._/-][A-Za-z0-9]+)*"): set text(font: 西文, weight: "bold", stroke: .2pt)
  text(font: 宋体, size: 四号, weight: "bold", stroke: .5pt)[#内容]
}
#let 封面线(内容) = box(width: 100%, height: 25pt, stroke: (bottom: 1pt), inset: (bottom: 3pt), align(center + horizon, 封面文字(内容)))
#let 封面自动行(内容) = layout(size => {
  let 行集 = (); let 当前 = ""
  // 英文单词和数字整体保留；中文按字测宽，防止把 SpringBoot 等单词截断。
  for 词 in 内容.matches(regex("[A-Za-z0-9]+|.")).map(项 => 项.text) {
    let 候选 = 当前 + 词
    if 当前 != "" and measure(封面文字(候选)).width > size.width - 3pt {
      行集.push(当前.trim()); 当前 = 词.trim(at: start)
    } else { 当前 = 候选 }
  }
  if 当前 != "" { 行集.push(当前.trim()) }
  if 行集.len() == 0 { 行集.push("") }
  stack(spacing: 15pt, ..行集.map(封面线))
})
#let 封面行(标签, 内容) = (
  align(right, text(font: 宋体, size: 四号, weight: "bold", stroke: .5pt)[#标签]),
  if type(内容) == str { 封面自动行(内容) } else { stack(spacing: 15pt, ..内容.map(封面线)) },
)
// 信息字典键名：题目 / 学院 / 专业班级 / 姓名 / 学号 / 校内导师 / 校外导师 / 时间；
// 缺省时留空，避免因漏填而报错。
#let 封面(信息) = page(paper: "a4", margin: 封面边距, header: none, footer: none, numbering: none)[
  #set par(first-line-indent: 0pt, justify: false, leading: 7pt, spacing: 0pt)
  #align(center, image(校徽路径, width: 91%))
  #v(0.6cm)
  #align(center, par(leading: 50pt - 小初, text(font: 黑体, size: 小初, weight: "bold", stroke: 1.2pt)[本科毕业论文（设计）]))
  #v(1.5cm)
  #align(center, block(width: 63%, grid(columns: (6em, 1fr), row-gutter: 16pt,
    ..封面行([题　　目：], 信息.at("题目", default: ([],))),
    ..封面行([学　　院：], 信息.at("学院", default: ([],))),
    ..封面行([专业班级：], 信息.at("专业班级", default: ([],))),
    ..封面行([学生姓名：], 信息.at("姓名", default: ([],))),
    ..封面行([学　　号：], 信息.at("学号", default: ([],))),
    ..封面行([校内导师：], 信息.at("校内导师", default: ([],))),
    ..封面行([校外导师：], 信息.at("校外导师", default: ([],))),
    ..封面行([完成时间：], 信息.at("时间", default: ([],))),
  )))
]

// ---------- 诚信承诺：只保留页面与标题版式，正文、签名、日期均由“Chaper/诚信承诺.typ”传入 ----------
#let 诚信承诺(body) = page(paper: "a4", margin: 正文边距, header: none, footer: none, numbering: none)[
  #set par(first-line-indent: 0pt, spacing: 0pt)
  #align(center, text(font: 黑体, size: 小二, weight: "bold")[诚#h(.5em)信#h(.5em)承#h(.5em)诺])
  #v(.8cm)
    #{
    set text(font: 宋体, size: 四号) // 承诺正文与签名使用宋体四号
    set par(justify: true, leading: 承诺行距 - 四号, first-line-indent: (amount: 2em, all: true))
    body
  }
]

// ---------- 摘要与目录：罗马页码，只在第一个前置页重置一次 ----------
#let 中文摘要(关键词: (), body) = page(paper: "a4", margin: 正文边距, numbering: "I", footer: 页脚)[
  #前置起始()
  #set par(first-line-indent: 0pt, spacing: 0pt)
  #align(center, text(font: 黑体, size: 三号, weight: "bold", 信息.title))
  #v(40pt)
  #前置标题[摘　要]
  #{
    set text(font: 宋体, size: 五号)
    
set par(justify: true, leading: 摘要行距 - 五号, spacing: 摘要行距 - 五号, first-line-indent: (amount: 2em, all: true))

    body
  }
  #v(12pt)
  
  // 中文摘要关键词：宋体小四加粗，英文数字新罗马加粗，左缩进24pt
  #pad(left: 21pt)[
    #set text(font: 宋体, size: 小四, weight: "regular", stroke: 0.0285em)
    #set par(first-line-indent: 0pt, spacing: 0pt, leading: 正文行距 - 小四)
    #show strong: it => it.body
    #show regex("[A-Za-z0-9]+(?:[._/-][A-Za-z0-9]+)*"): set text(font: 西文, weight: "bold", stroke: none)
    关键词：#关键词.join("；")
  ]

]
#let 英文摘要(关键词: (), body) = page(paper: "a4", margin: 正文边距, numbering: "I", footer: 页脚)[
  #前置起始()
  #set text(font: 西文, lang: "en")
  #set par(first-line-indent: 0pt, spacing: 0pt)
  #align(center, par(leading: 20pt - 四号, text(size: 四号, weight: "bold", 信息.title-en)))
  #v(42pt)
  #align(center, text(size: 四号, weight: "bold")[Abstract])
  #v(6pt)
  #{
    set text(size: 五号)
    
set par(justify: true, leading: 摘要行距 - 五号, spacing: 摘要行距 - 五号, first-line-indent: (amount: 2em, all: true))

    body
  }
  #v(12pt)
  #pad(left: 21pt, text(size: 小四, weight: "bold")[Keywords: #关键词.join("; ")])
]
#let 目录() = page(paper: "a4", margin: 正文边距, numbering: "I", footer: 页脚)[
  #前置起始()
  #set text(cjk-latin-spacing: none)
  #set par(first-line-indent: 0pt, leading: 正文行距 - 小四, spacing: 0pt)
  // 目录标题黑体三号居中；目录条目（含序号、标题和页码）宋体小四、仅描边模拟加粗。
  #align(center, block(above: 0pt, below: 6pt, text(font: 黑体, size: 三号, weight: "bold")[目　　录]))
  #show outline.entry: set text(font: 宋体, size: 小四, weight: "regular", stroke: 0.0285em)
  #outline(title: none, depth: 2, indent: auto) // 仅显示一级、二级目录；需要三级时改为 depth: 3
]

// ---------- 内容辅助函数：图表及可选后置部分，避免章节中出现样式设置 ----------
#let 论文表格(表头: (), 列数: 3, 标题: [], 数据: ()) = figure(
  table(columns: if 列数 == 2 { (auto, 1fr) } else { 列数 }, align: if 列数 == 2 { left } else { center }, stroke: none, inset: 5pt,
    table.hline(stroke: 1pt), table.header(..表头), table.hline(stroke: .5pt), ..数据, table.hline(stroke: 1pt)),
  caption: 标题,
)
#let 论文插图(路径, 标题) = figure(image("Figure/" + 路径, width: 70%), caption: 标题)
#let 致谢(body) = [#标题类型.update("ack")#heading(level: 1, numbering: none)[致　谢]#body#标题类型.update("chapter")]
#let 附录(编号: "A", 标题: [], body) = [#标题类型.update("appendix")#heading(level: 1, numbering: none)[附录#编号#h(1em)#标题]#body#标题类型.update("chapter")]
