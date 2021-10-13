.objects as $objects |

(
  [
    .objects[
      .objects[
        .objects[] | select(.isa == "PBXNativeTarget") | select(.name == $target).buildPhases[]
      ] | select(.isa == "PBXSourcesBuildPhase").files[]
    ].fileRef | {key: .}
  ] | from_entries
) as $files |

[.objects[.rootObject].mainGroup]
| recurse(. + ($objects[last].children[]? | [.]))
| select(last | in($files))[1:]
| map($objects[.].path) | join("/")
