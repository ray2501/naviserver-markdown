#
# markdown.tcl --
#
#   Add tclllib markdown support to NaviServer
#

#
# Register the ns_markdownfie handler for .md files
#

package require Markdown

ns_register_proc GET  /*.md ns_markdownfie

#
# ns_markdownfie --
#
#   Callback for Makrdown file.
#

proc ns_markdownfie {args} {

    set path [ns_url2file [ns_conn url]]
    if {![ns_filestat $path stat]} {
        ns_returnnotfound
        return
    }

    set infile [open $path]
    set md [read $infile]
    close $infile
    set data [encoding convertto utf-8 [::Markdown::convert $md]]

    ns_headers 200 "text/html;charset=utf-8"
    ns_write $data
}

# EOF
