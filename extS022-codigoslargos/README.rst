extS022-codigoslargos
=====================

Aumenta logitud de código de artículos en todos los módulos así como de las familias y subfamilas.
Se puede variar cantidad dentro de este con un  find ./build/final/ -name "*.mtd" -print | xargs sed -i "s%<length>18</length>%<length>31</length>%g" y otro para familias y luego aplicar el parche a todo.

