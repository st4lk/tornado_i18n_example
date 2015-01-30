#!/bin/bash 
# get arguments and init variables
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <locale> [optional: <domain_name>]"
    exit 1
fi
locale=$1
domain="messages"
if [ ! -z "$2" ]; then
    domain=$2
fi
base_dir="locale"
locale_dir="${base_dir}/${locale}/LC_MESSAGES"
pot_file="${base_dir}/${domain}.pot"
po_file="${locale_dir}/${domain}.po"
babel_config="${base_dir}/babel.cfg"
# create pot template
pybabel extract ./ --output=${pot_file} \
    --charset=UTF-8 --no-wrap --sort-by-file \
    --keyword=_ --keyword=_:1,2 --mapping=${babel_config}
# init .po file, if it doesn't exist yet
if [ ! -f $po_file ]; then
    pybabel init --input-file=${pot_file} --output-dir=${base_dir} \
        --domain=${domain} --locale=${locale} --no-wrap
else
    # update .po file
    pybabel update --domain=${domain} --input-file=${pot_file} \
    --output-dir=${base_dir} --locale=${locale} --no-wrap
fi
