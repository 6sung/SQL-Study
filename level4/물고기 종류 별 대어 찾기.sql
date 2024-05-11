select id, fish_name, length
from fish_info a inner join fish_name_info b
on a.fish_type = b.fish_type
where a.length = (select max(length)
                 from fish_info
                 group by fish_type
                 Having fish_type = a.fish_type)
order by id;
