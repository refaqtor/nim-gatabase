## **Gatabase:** Compile-time lightweight ORM for Postgres or SQLite.
## * SQL DSL mimics SQL syntax!, API mimics stdlib!, Simple just 9 Templates!.
##
## .. image:: https://raw.githubusercontent.com/juancarlospaco/nim-gatabase/master/temp.jpg
##
## More Documentation
## ------------------
##
## * `Gatabase Sugar <https://juancarlospaco.github.io/nim-gatabase/sugar.html>`_ **Recommended**, but Optional, all Templates.
## * DSL use https://github.com/juancarlospaco/nim-gatabase#gatabase
import macros
include gatabase/templates # Tiny compile-time internal templates that do 1 thing.


macro cueri(inner: untyped): auto =
  var
    offsetUsed, limitUsed, fromUsed, whereUsed, orderUsed, selectUsed,
      deleteUsed, likeUsed, valuesUsed, betweenUsed, joinUsed, groupbyUsed,
      havingUsed, intoUsed, insertUsed, isnullUsed, resetUsed, updateUsed: bool
    sqls: string
  const err0 = "Wrong Syntax, nested SubQueries not supported, repeated call found. "
  for node in inner:
    doAssert node.kind == nnkCommand, "Wrong DSL Syntax, must be nnkCommand, but is " & $node.kind
    case $node[0]
    of "limit":
      doAssert not limitUsed, err0
      doAssert fromUsed, err0 & "LIMIT without FROM"
      doAssert selectUsed or insertUsed or deleteUsed, err0 & """
      LIMIT without SELECT nor INSERT nor UPDATE nor DELETE"""
      sqls.add limits(node[1])
      limitUsed = true
    of "offset":
      doAssert not offsetUsed, err0
      doAssert limitUsed, err0 & "OFFSET without LIMIT"
      doAssert selectUsed or insertUsed or deleteUsed, err0 & """
      OFFSET without SELECT nor INSERT nor UPDATE nor DELETE"""
      sqls.add offsets(node[1])
      offsetUsed = true
    of "from":
      doAssert not fromUsed, err0
      doAssert selectUsed or deleteUsed, err0 & "FROM without SELECT nor DELETE"
      sqls.add froms(node[1])
      fromUsed = true
    of "where":
      doAssert not whereUsed, err0
      doAssert selectUsed or insertUsed or deleteUsed, err0 & """
      WHERE without SELECT nor INSERT nor UPDATE nor DELETE"""
      sqls.add wheres(node[1])
      whereUsed = true
    of "wherenot":
      doAssert not whereUsed, err0
      doAssert selectUsed or insertUsed or deleteUsed, err0 & """
      WHERE NOT without SELECT nor INSERT nor UPDATE nor DELETE"""
      sqls.add whereNots(node[1])
      whereUsed = true
    of "whereexists":
      doAssert not whereUsed, err0
      doAssert selectUsed or insertUsed or deleteUsed, err0 & """
      WHERE EXISTS without SELECT nor INSERT nor UPDATE nor DELETE"""
      sqls.add whereExists(node[1])
      whereUsed = true
    of "wherenotexists":
      doAssert not whereUsed, err0
      doAssert selectUsed or insertUsed or deleteUsed, err0 & """
      WHERE NOT EXISTS without SELECT nor INSERT nor UPDATE nor DELETE"""
      sqls.add whereNotExists(node[1])
      whereUsed = true
    of "order", "orderby":
      doAssert not orderUsed, err0
      doAssert selectUsed, err0 & "ORDER BY without SELECT"
      doAssert node[1] is GatabaseOrderBy
      sqls.add orderbys($node[1])
      orderUsed = true
    of "select":
      doAssert not selectUsed, err0
      sqls.add selects(node[1])
      selectUsed = true
    of "selectdistinct":
      doAssert not selectUsed, err0
      sqls.add selectDistincts(node[1])
      selectUsed = true
    of "delete":
      doAssert not deleteUsed, err0
      sqls.add deletes(node[1])
      deleteUsed = true
    of "like":
      doAssert not likeUsed and whereUsed, err0
      doAssert selectUsed or whereUsed or insertUsed or deleteUsed, err0 & """
      LIKE without WHERE nor SELECT nor INSERT nor UPDATE nor DELETE"""
      sqls.add likes(node[1])
      likeUsed = true
    of "notlike":
      doAssert not likeUsed and whereUsed, err0
      doAssert selectUsed or whereUsed or insertUsed or deleteUsed, err0 & """
      NOT LIKE without WHERE nor SELECT nor INSERT nor UPDATE nor DELETE"""
      sqls.add notlikes(node[1])
      likeUsed = true
    of "between":
      doAssert not betweenUsed and whereUsed, err0
      doAssert selectUsed or insertUsed or deleteUsed, err0 & """
      BETWEEN without SELECT nor INSERT nor UPDATE nor DELETE"""
      sqls.add betweens(node[1])
      betweenUsed = true
    of "notbetween":
      doAssert not betweenUsed and whereUsed, err0
      doAssert selectUsed or insertUsed or deleteUsed, err0 & """
      NOT BETWEEN without SELECT nor INSERT nor UPDATE nor DELETE"""
      sqls.add notbetweens(node[1])
      betweenUsed = true
    of "groupby", "group":
      doAssert not groupbyUsed, err0
      doAssert selectUsed, err0 & "GROUP BY without SELECT"
      sqls.add groupbys(node[1])
      groupbyUsed = true
    of "into":
      doAssert not intoUsed, err0
      doAssert selectUsed, err0 & "INTO without SELECT"
      sqls.add intos(node[1])
      intoUsed = true
    of "insert", "insertinto":
      doAssert not insertUsed, err0
      sqls.add inserts(node[1])
      insertUsed = true
    of "update":
      doAssert not updateUsed, err0
      sqls.add updates(node[1])
      updateUsed = true
    of "set":
      doAssert updateUsed, "SET without UPDATE"
      sqls.add sets(node[1])
    of "values": # This is the only ones that actually take values.
      {.linearScanEnd.} # https://nim-lang.github.io/Nim/manual.html#pragmas-linearscanend-pragma
      doAssert not valuesUsed, err0  # Below put the less frequently used case branches.
      doAssert insertUsed, err0 & "VALUES without INSERT INTO"
      sqls.add values(node[1].intVal.Positive)
      valuesUsed = true
    of "--": sqls.add sqlComment($node[1])
    of "having":
      doAssert not havingUsed, err0
      doAssert groupbyUsed, err0 & "HAVING without GROUP BY"
      sqls.add havings(node[1])
      havingUsed = true
    of "selecttop":
      doAssert not selectUsed, err0
      sqls.add selectTops(node[1])
      selectUsed = true
    of "selectmin":
      doAssert not selectUsed, err0
      sqls.add selectMins(node[1])
      selectUsed = true
    of "selectmax":
      doAssert not selectUsed, err0
      sqls.add selectMaxs(node[1])
      selectUsed = true
    of "selectcount":
      doAssert not selectUsed, err0
      sqls.add selectCounts(node[1])
      selectUsed = true
    of "selectavg":
      doAssert not selectUsed, err0
      sqls.add selectAvgs(node[1])
      selectUsed = true
    of "selectsum":
      doAssert not selectUsed, err0
      sqls.add selectSums(node[1])
      selectUsed = true
    of "selecttrim":
      doAssert not selectUsed, err0
      sqls.add selectTrims(node[1])
      selectUsed = true
    of "selectround2":
      doAssert not selectUsed, err0
      sqls.add selectRound2(node[1])
      selectUsed = true
    of "selectround4":
      doAssert not selectUsed, err0
      sqls.add selectRound4(node[1])
      selectUsed = true
    of "selectround6":
      doAssert not selectUsed, err0
      sqls.add selectRound6(node[1])
      selectUsed = true
    of "union":
      doAssert not resetUsed, err0
      resetAllGuards()
      sqls.add unions(node[1])
      resetUsed = true
    of "intersect":
      doAssert not resetUsed, err0
      resetAllGuards()
      sqls.add intersects(node[1])
      resetUsed = true
    of "except":
      doAssert not resetUsed, err0
      resetAllGuards()
      sqls.add excepts(node[1])
      resetUsed = true
    of "isnull":
      doAssert not isnullUsed, err0
      doAssert selectUsed or insertUsed or deleteUsed, err0 & """
      IS NULL without SELECT nor INSERT nor UPDATE nor DELETE"""
      sqls.add isnulls(node[1])
      isnullUsed = true
    of "innerjoin":
      doAssert not joinUsed, err0
      doAssert selectUsed, err0 & "INNER JOIN without SELECT"
      sqls.add innerjoins(node[1])
      joinUsed = true
    of "leftjoin":
      doAssert not joinUsed, err0
      doAssert selectUsed, err0 & "LEFT JOIN without SELECT"
      sqls.add leftjoins(node[1])
      joinUsed = true
    of "rightjoin":
      doAssert not joinUsed, err0
      doAssert selectUsed, err0 & "RIGHT JOIN without SELECT"
      sqls.add rightjoins(node[1])
      joinUsed = true
    of "fulljoin":
      doAssert not joinUsed, err0
      doAssert selectUsed, err0 & "FULL JOIN without SELECT"
      sqls.add fulljoins(node[1])
      joinUsed = true
    of "case": sqls.add cases(node[1])
    of "commentoncolumn": sqls.add comments(node[1], "COLUMN")
    of "commentondatabase": sqls.add comments(node[1], "DATABASE")
    of "commentonfunction": sqls.add comments(node[1], "FUNCTION")
    of "commentonindex": sqls.add comments(node[1], "INDEX")
    of "commentontable": sqls.add comments(node[1], "TABLE")
    else: doAssert false, "Unknown syntax error on ORMs DSL: " & inner.lineInfo
  when not defined(release) or not defined(danger):
    if unlikely(deleteUsed and not whereUsed): {.warning: "DELETE FROM without WHERE.".}
  assert sqls.len > 0, "Unknown error on SQL DSL, SQL Query must not be empty."
  sqls.add when defined(release): ";" else: ";  /* " & inner.lineInfo & " */\n"
  when defined(dev): echo sqls
  result = quote do: sql(`sqls`)

template exec*(args: varargs[string, `$`]; inner: untyped) =
  ## Mimics `exec` but using Gatabase DSL.
  ## * `args` are passed as-is to `exec()`, if no `args` use `[]`, example `[42, "OwO", true]`.
  ##
  ## .. code-block::nim
  ##   exec []:
  ##     delete "person"
  ##     where "active = false"
  exec(db, cueri(inner), args)

template tryExec*(args: varargs[string, `$`]; inner: untyped): bool =
  ## Mimics `tryExec` but using Gatabase DSL.
  ## * `args` are passed as-is to `tryExec()`, if no `args` use `[]`, example `[42, "OwO", true]`.
  ##
  ## .. code-block::nim
  ##   let killUser: bool = tryExec []:
  ##     delete "person"
  ##     where "id = 42"
  ##
  ## .. code-block::nim
  ##   let killUser: bool = tryExec []:
  ##     select "name"
  ##     `from` "person"
  ##     wherenot "active = true"
  tryExec(db, cueri(inner), args)

template getRow*(args: varargs[string, `$`]; inner: untyped): auto =
  ## Mimics `getRow` but using Gatabase DSL.
  ## * `args` are passed as-is to `getRow()`, if no `args` use `[]`, example `[42, "OwO", true]`.
  ##
  ## .. code-block::nim
  ##   let topUser: Row = getAllRows []:
  ##     selecttop "username"
  ##     `from` "person"
  ##     limit 1
  getRow(db, cueri(inner), args)

template getAllRows*(args: varargs[string, `$`]; inner: untyped): auto =
  ## Mimics `getAllRows` but using Gatabase DSL.
  ## * `args` are passed as-is to `getAllRows()`, if no `args` use `[]`, example `[42, "OwO", true]`.
  ##
  ## .. code-block::nim
  ##   let allUsers: seq[Row] = [].getAllRows:
  ##     select '*'
  ##     `from` "person"
  ##
  ## .. code-block::nim
  ##   var allUsers: seq[Row] = getAllRows []:
  ##     selectdistinct "names"
  ##     `from` "person"
  getAllRows(db, cueri(inner), args)

template getValue*(args: varargs[string, `$`]; inner: untyped): string =
  ## Mimics `getValue` but using Gatabase DSL.
  ## * `args` are passed as-is to `getValue()`, if no `args` use `[]`, example `[42, "OwO", true]`.
  ##
  ## .. code-block::nim
  ##   let userName: string = [].getValue:
  ##     select "name"
  ##     `from` "person"
  ##     where  "id = 42"
  ##
  ## .. code-block::nim
  ##   let age: string = getValue []:
  ##     select "age"
  ##     `from` "person"
  ##     orderby DescNullsLast
  ##     limit 1
  getValue(db, cueri(inner), args)

template tryInsertID*(args: varargs[string, `$`]; inner: untyped): int64 =
  ## Mimics `tryInsertID` but using Gatabase DSL.
  ## * `args` are passed as-is to `tryInsertID()`, if no `args` use `[]`, example `[42, "OwO", true]`.
  ##
  ## .. code-block::nim
  ##   let newUser: int64 = tryInsertID ["Graydon Hoare", "graydon.hoare@nim-lang.org"]:
  ##     insertinto "person"
  ##     values 2
  tryInsertID(db, cueri(inner), args)

template insertID*(args: varargs[string, `$`]; inner: untyped): int64 =
  ## Mimics `insertID` but using Gatabase DSL.
  ## * `args` are passed as-is to `insertID()`, if no `args` use `[]`, example `[42, "OwO", true]`.
  ##
  ## .. code-block::nim
  ##   let newUser: int64 = ["Ryan Dahl", "ryan.dahl@nim-lang.org"].insertID:
  ##     insertinto "person"
  ##     values 2
  insertID(db, cueri(inner), args)

template execAffectedRows*(args: varargs[string, `$`]; inner: untyped): int64 =
  ## Mimics `execAffectedRows` but using Gatabase DSL.
  ## * `args` are passed as-is to `execAffectedRows()`, if no `args` use `[]`, example `[42, "OwO", true]`.
  ##
  ## .. code-block::nim
  ##   let activeUsers: int64 = execAffectedRows []:
  ##     select "status"
  ##     `from` "users"
  ##     `--`  "This is a SQL comment"
  ##     where "status = true"
  ##     isnull false
  ##
  ## .. code-block::nim
  ##   let distinctNames: int64 = execAffectedRows []:
  ##     selectdistinct "name"
  ##     `from` "users"
  execAffectedRows(db, cueri(inner), args)

template getValue*(args: varargs[string, `$`]; parseProc: proc; inner: untyped): auto =
  ## Alias for `parseProc(getValue(db, sql("..."), args))`. **Returns actual value instead of string**.
  ## * `parseProc` is whatever proc parses the value of `getValue()`, any proc should work.
  ## * `args` are passed as-is to `getValue()`, if no `args` use `[]`, example `[42, "OwO", true]`.
  ##
  ## .. code-block::nim
  ##   let age: int = getValue([], parseInt):
  ##     select "age"
  ##     `from` "users"
  ##     limit 1
  ##
  ## .. code-block::nim
  ##   let ranking: float = getValue([], parseFloat):
  ##     select "ranking"
  ##     `from` "users"
  ##     where "id = 42"
  ##
  ## .. code-block::nim
  ##   let preferredColor: string = [].getValue(parseHexStr):
  ##     select "color"
  ##     `from` "users"
  ##     limit 1
  parseProc(getValue(args, inner))

template sqls*(inner: untyped): auto =
  ## Build a `SqlQuery` using Gatabase ORM DSL, returns a vanilla `SqlQuery`.
  ##
  ## .. code-block::nim
  ##   const data: SqlQuery = sqls:
  ##     select '*'
  ##     `from` "users"
  ##
  ## .. code-block::nim
  ##   let data: SqlQuery = sqls:
  ##     select "name"
  ##     `from` "users"
  ##     limit 9
  ##
  ## .. code-block::nim
  ##   var data: SqlQuery = sqls:
  ##     delete '*'
  ##     `from` "users"
  cueri(inner)
