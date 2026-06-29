" Org-mode syntax highlighting
if exists("b:current_syntax")
  finish
endif

" Headlines
syntax match orgHeadline1 "^\* .*$"
syntax match orgHeadline2 "^\*\* .*$"
syntax match orgHeadline3 "^\*\*\* .*$"
syntax match orgHeadline4 "^\*\*\*\* .*$"
syntax match orgHeadline5 "^\*\*\*\*\* .*$"
syntax match orgHeadline6 "^\*\*\*\*\*\* .*$"

" TODO keywords - Main sequence
syntax match orgTODO "\<TODO\>" contained containedin=orgHeadline1,orgHeadline2,orgHeadline3,orgHeadline4,orgHeadline5,orgHeadline6
syntax match orgNEXT "\<NEXT\>" contained containedin=orgHeadline1,orgHeadline2,orgHeadline3,orgHeadline4,orgHeadline5,orgHeadline6
syntax match orgWIP "\<WIP\>" contained containedin=orgHeadline1,orgHeadline2,orgHeadline3,orgHeadline4,orgHeadline5,orgHeadline6
syntax match orgAWAIT "\<AWAIT\>" contained containedin=orgHeadline1,orgHeadline2,orgHeadline3,orgHeadline4,orgHeadline5,orgHeadline6
syntax match orgBLOCKED "\<BLOCKED\>" contained containedin=orgHeadline1,orgHeadline2,orgHeadline3,orgHeadline4,orgHeadline5,orgHeadline6
syntax match orgIDEA "\<IDEA\>" contained containedin=orgHeadline1,orgHeadline2,orgHeadline3,orgHeadline4,orgHeadline5,orgHeadline6
syntax match orgMAYBE "\<MAYBE\>" contained containedin=orgHeadline1,orgHeadline2,orgHeadline3,orgHeadline4,orgHeadline5,orgHeadline6
syntax match orgDONE "\<DONE\>" contained containedin=orgHeadline1,orgHeadline2,orgHeadline3,orgHeadline4,orgHeadline5,orgHeadline6
syntax match orgNOTDOING "\<NOTDOING\>" contained containedin=orgHeadline1,orgHeadline2,orgHeadline3,orgHeadline4,orgHeadline5,orgHeadline6

" Meeting keywords
syntax match orgMEETING "\<MEETING\>" contained containedin=orgHeadline1,orgHeadline2,orgHeadline3,orgHeadline4,orgHeadline5,orgHeadline6
syntax match orgENDED "\<ENDED\>" contained containedin=orgHeadline1,orgHeadline2,orgHeadline3,orgHeadline4,orgHeadline5,orgHeadline6
syntax match orgCANCELED "\<CANCELED\>" contained containedin=orgHeadline1,orgHeadline2,orgHeadline3,orgHeadline4,orgHeadline5,orgHeadline6
syntax match orgSKIPPED "\<SKIPPED\>" contained containedin=orgHeadline1,orgHeadline2,orgHeadline3,orgHeadline4,orgHeadline5,orgHeadline6

" Checkboxes
syntax match orgCheckbox "\[ \]"
syntax match orgCheckboxHalf "\[-\]"
syntax match orgCheckboxDone "\[x\]"

" Timestamps
syntax match orgTimestampActive "<\d\{4\}-\d\{2\}-\d\{2\}[^>]*>"
syntax match orgTimestampInactive "\[\d\{4\}-\d\{2\}-\d\{2\}[^\]]*\]"

" Drawers
syntax match orgDrawer "^\s*:\(PROPERTIES\|LOGBOOK\|END\):.*$"

" Properties/Meta
syntax match orgMeta "^#\+.*$"

" Links
syntax match orgLink "\[\[.\{-}\]\]"

" Emphasis
syntax match orgBold "\*[^*]\+\*"
syntax match orgItalic "/[^/]\+/"
syntax match orgUnderline "_[^_]\+_"
syntax match orgCode "=[^=]\+="
syntax match orgVerbatim "\~[^~]\+\~"

" Define highlight groups
hi def link orgHeadline1 Title
hi def link orgHeadline2 Title
hi def link orgHeadline3 Title
hi def link orgHeadline4 Title
hi def link orgHeadline5 Title
hi def link orgHeadline6 Title

" TODO keywords - differentiated colors
hi def orgTODO guifg=#d08770 ctermfg=173 gui=bold cterm=bold
hi def orgNEXT guifg=#ebcb8b ctermfg=221 gui=bold cterm=bold
hi def orgWIP guifg=#a3be8c ctermfg=143 gui=bold cterm=bold
hi def orgAWAIT guifg=#b48ead ctermfg=139 gui=bold cterm=bold
hi def orgBLOCKED guifg=#bf616a ctermfg=131 gui=bold cterm=bold
hi def orgIDEA guifg=#88c0d0 ctermfg=110 gui=bold cterm=bold
hi def orgMAYBE guifg=#5e81ac ctermfg=67 gui=bold cterm=bold
hi def orgDONE guifg=#a3be8c ctermfg=143 gui=bold cterm=bold
hi def orgNOTDOING guifg=#4c566a ctermfg=240 gui=bold cterm=bold

" Meeting keywords
hi def orgMEETING guifg=#81a1c1 ctermfg=109 gui=bold cterm=bold
hi def orgENDED guifg=#a3be8c ctermfg=143 gui=bold cterm=bold
hi def orgCANCELED guifg=#4c566a ctermfg=240 gui=bold cterm=bold
hi def orgSKIPPED guifg=#4c566a ctermfg=240 gui=bold cterm=bold

" Other elements
hi def link orgCheckbox Todo
hi def link orgCheckboxHalf Special
hi def link orgCheckboxDone Comment
hi def link orgTimestampActive String
hi def link orgTimestampInactive Comment
hi def link orgDrawer Comment
hi def link orgMeta Comment
hi def link orgLink Underlined
hi def orgBold gui=bold cterm=bold
hi def orgItalic gui=italic cterm=italic
hi def orgUnderline gui=underline cterm=underline
hi def link orgCode String
hi def link orgVerbatim String

let b:current_syntax = "org"
