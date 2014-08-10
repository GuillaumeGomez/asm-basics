# asm-hello-world - Copyright (c) 2014 Gomez Guillaume.
#
# This software is provided 'as-is', without any express or implied warranty.
# In no event will the authors be held liable for any damages arising from
# the use of this software.
#
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
#
# 1. The origin of this software must not be misrepresented; you must not claim
#    that you wrote the original software. If you use this software in a product,
#    an acknowledgment in the product documentation would be appreciated but is
#    not required.
#
# 2. Altered source versions must be plainly marked as such, and must not be
#    misrepresented as being the original software.
#
# 3. This notice may not be removed or altered from any source distribution.

examples_x64:
	mkdir -p bin
	nasm -f elf64 examples/hello_world/test.asm -o bin/test.o
	ld bin/test.o -o bin/hello_world
	rm bin/test.o

examples_x86:
	mkdir -p bin
	nasm -f elf examples/hello_world/test.asm -o bin/test.o
	ld bin/test.o -o bin/hello_world
	rm bin/test.o

clean:
	rm bin/hello_world

re: clean examples_x64

re_x86: clean examples_x86
