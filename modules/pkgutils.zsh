
pkgutils:no_binary_fetch() { : }

pkgutils:get_installed_packages_list() {
	pkginfo -i | cut -d " " -f 1
}

pkgutils:get_installation_date() {
	if pkgutils:is_installed $1; then
		echo 0 # How can I get *that* on Crux?
	else
		echo - -
	fi
}

pkgutils:get_collection() {
	typeset -la collections collection
	collections=( "$PORTS_DIR"/* )

	for C in $collections[*]; do
		[[ -e "$C/$1" && -e "$C/$1/Pkgfile" ]] && \
			collection=$C && \
			break
	done

	collection=$( echo $collection | sed "s&$PORTS_DIR/&&" )

	if [[ -z "$collection" ]]; then
		collection=$( portdbc search $1 | grep "^$1 " | head -n1 | sed "s/$1 *//;s/ .*//" )
	fi

	[[ -n "$collection" ]] && echo "$collection" || \
		echo - -
}

pkgutils:get_installed_version() {
	pkginfo -i | grep "^$1 " | cut -d " " -f 2
}

pkgutils:get_available_version() {
	local collection=$(pkgutils:get_collection $1)
		
	if [[ -d "$PORTS_DIR/$collection" ]]; then
		zsh -c ". $PORTS_DIR/$collection/$1/Pkgfile; echo \$version-\$release" 2>/dev/null
	else
		pkgutils:get_installed_version $1
	fi
}

# I don’t remember having seen conflicts or provides in any Crux recipe…
pkgutils:get_conflicts() {
	:
}
pkgutils:get_provides() {
	:
}

pkgutils:is_installed() {
	grep -q "^$1$" /var/lib/pkg/db
}

pkgutils:is_installed_as_dep() {
	false
}

pkgutils:get_architecture() {
	crux | cut -d " " -f 2
}

pkgutils:packages_installer() {
	if pkgutils:is_installed $1; then
		as_root pkg++ -i -u
	else
		as_root pkg++ -i
	fi
}

pkgutils:dependencies_installer() {
	die "Installing binary packages is still unsupported."
}

