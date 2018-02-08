import "elf"

rule gcc_45x
{
	meta:
		tool = "C"
		name = "GCC"
		version = "4.5.x"
		pattern = "780B297C3600215400000038F0FF2194A603087C000001900?10003D????A885????0048E0FF2194A602087C1?00?193??10?03F24000190????1?881?00?1930000802F1?00?1931?00?193??009E40??10?03F??10?03F??????3B??????3B"
	strings:
		$1 = { 78 0B 29 7C 36 00 21 54 00 00 00 38 F0 FF 21 94 A6 03 08 7C 00 00 01 90 0? 10 00 3D ?? ?? A8 85 ?? ?? 00 48 E0 FF 21 94 A6 02 08 7C 1? 00 ?1 93 ?? 10 ?0 3F 24 00 01 90 ?? ?? 1? 88 1? 00 ?1 93 00 00 80 2F 1? 00 ?1 93 1? 00 ?1 93 ?? 00 9E 40 ?? 10 ?0 3F ?? 10 ?0 3F ?? ?? ?? 3B ?? ?? ?? 3B }
	condition:
		$1 at elf.entry_point
}

rule gcc_45x_2
{
	meta:
		tool = "C"
		name = "GCC"
		version = "4.5.x"
		pattern = "7C290B7854210036380000009421FFF07C0803A6900100003D00100?85A8????4800????9421FFE07C0802A693?1001?3F?010??90010024881?????93?1001?2F80000093?1001?93?1001?409E00??3F?010??3F?010??3B??????3B??????3F?010"
	strings:
		$1 = { 7C 29 0B 78 54 21 00 36 38 00 00 00 94 21 FF F0 7C 08 03 A6 90 01 00 00 3D 00 10 0? 85 A8 ?? ?? 48 00 ?? ?? 94 21 FF E0 7C 08 02 A6 93 ?1 00 1? 3F ?0 10 ?? 90 01 00 24 88 1? ?? ?? 93 ?1 00 1? 2F 80 00 00 93 ?1 00 1? 93 ?1 00 1? 40 9E 00 ?? 3F ?0 10 ?? 3F ?0 10 ?? 3B ?? ?? ?? 3B ?? ?? ?? 3F ?0 10 }
	condition:
		$1 at elf.entry_point
}
