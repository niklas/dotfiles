# Git Status in Prompt
parse_git_branch ()
{
   dirty=$(git status 2> /dev/null | tail -n1 | sed -e '/^nothing.*/d' | sed -e 's/.*/*/')
	git name-rev HEAD 2> /dev/null | sed "s#HEAD\ \(.*\)#[\1$dirty]#" || ''
}
parse_svn_branch() {
	parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk -F / '{print "("$1 "/" $2 ")"}'
}
parse_svn_url() {
	svn info 2>/dev/null | sed -ne 's#^URL: ##p'
}
parse_svn_repository_root() {
	svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p'
}
