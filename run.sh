#!/bin/bash

ruby tmda_ci_main.rb \
	--database data/tsd \
	--group_sql 'select distinct name from random_02' \
	--source_sql 'select * from random_02' \
	--function sum --function_argument 1 \
	--theta 0-0 \
	--c c

ruby tmda_fi_main.rb \
	--database data/tsd \
	--group_sql 'select * from groups_random_02' \
	--source_sql 'select * from random_02' \
	--function sum --function_argument 1 \
	--theta 0-0 \
	--c c