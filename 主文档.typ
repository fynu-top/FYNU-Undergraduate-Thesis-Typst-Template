// ============================================================
// 主文档：仅负责引入模板并按顺序引入各章节，不写任何样式设置。
//   - 需要启用某章节时，删除对应 #include 行前的 “//”；
//   - 封面、诚信承诺、摘要、目录、正文、参考文献、致谢、附录的顺序
//     建议按学校装订顺序排列，可按需调整。
//   - 个人信息：封面信息在 Chaper/封面.typ，中英文题目等全局信息在 论文信息.typ。
// ============================================================
#import "模板样式.typ": fynu-thesis
#show: fynu-thesis
#include "Chaper/封面.typ"
#include "Chaper/诚信承诺.typ"
#include "Chaper/中英文摘要.typ"
#include "Chaper/目录.typ"
#include "Chaper/01_绪论.typ"
#include "Chaper/02_相关技术.typ"
#include "Chaper/03_系统分析.typ"
#include "Chaper/04_系统设计.typ"
#include "Chaper/05_系统实现.typ"
#bibliography("参考文献.bib", title: none) // 不需要时注释本行，并移除正文文献引用。
#include "Chaper/21_致谢.typ"
#include "Chaper/22_附录A.typ"
