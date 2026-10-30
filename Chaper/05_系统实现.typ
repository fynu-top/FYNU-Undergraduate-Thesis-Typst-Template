// ============================================================
// 第 5 章示例：系统实现。用法同“01_绪论.typ”。
//   - 注意：每章开头都要有 #import "../模板样式.typ": 正文 和 #正文() 两行，
//     否则本章不会从新页开始、页码也可能错乱。
//   - 数据库表可用三线表形式：#论文表格(...)，或直接用 #figure(table(...), caption: [...])。
// ============================================================
#import "../模板样式.typ": 正文
#正文()

= 系统实现


== 管理员端实现
系统分为用户界面、业务服务和数据存储三部分。用户界面提供基础数据录入与课表展示，业务服务处理权限检查和排课约束，数据存储保存教学资源与课表结果。 给出总体架构示例。



// #figure(
//   image("../Figure/5/课程管理界面.png", width: 100%),
//   caption: [课程管理界面],
// ) <课程管理界面>
// @课程管理界面 给出了系统的总体架构图。

== 教师员端实现

#figure(
  image("../Figure/5/教师管理界面.png", width: 100%),
  caption: [教师管理界面],
) <教师管理界面1>

@教师管理界面1 给出了...

== 学生端实现



#figure(
  align(center)[
    #table(
      columns: (auto, auto, auto, auto),
      align: (left, center, center, center),
      stroke: none,
      table.hline(stroke: 1.2pt),
      table.header([说明], [字段名], [数据类型], [长度]),
      table.hline(stroke: 0.6pt),
      [消息 ID], [id], [int], [11],
      [接收人 ID], [receiver_id], [int], [11],
      [消息类型], [message_type], [int], [11],
      [消息标题], [title], [varchar], [200],
      [消息内容], [content], [text], [-],
      [是否已读], [is_read], [int], [1],
      [创建时间], [creation_time], [datetime], [-],
      table.hline(stroke: 1.2pt),
    )
  ],
  caption: [消息表结构设计],
) <tab:message-table>


@tab:message-table 给出了信息。



#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    align: (left, center, center, center, center, center, center),
    stroke: none,
    table.hline(stroke: 1.5pt),
    table.header([], [2002 年], [2003 年], [2004 年], [2005 年], [2006 年], [2007 年]),
    table.hline(stroke: 0.6pt),
    [基金收入], [387.8], [470.6], [529.9], [601.6], [677.2], [823.6],
    [基金支出], [340.1], [405.9], [470.9], [545.0], [609.4], [811.3],
    [累计结余], [364.5], [441.7], [475.7], [534.3], [619.8], [633.2],
    table.hline(stroke: 1.5pt),
  ),
  caption: [2002-2007 年全国机关事业单位基本养老保险基金收支及累计结余],
) <tab:pension-fund>

@tab:pension-fund 给出了模板中的表格。

