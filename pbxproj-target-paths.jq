.objects as $objects |

(
  [
    [.objects[.rootObject].mainGroup]
    | recurse(. + ($objects[last].children[]? | [.]))
  ] | INDEX(last)
)[
  .objects[
    .objects[
      .objects[] | select(.isa == "PBXNativeTarget") | select(.name == $target).buildPhases[]
    ] | select(.isa == "PBXSourcesBuildPhase").files[]
  ].fileRef
][1:]
| map($objects[.].path) | join("/")
