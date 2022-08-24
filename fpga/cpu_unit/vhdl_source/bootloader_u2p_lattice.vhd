-- The NEORV32 RISC-V Processor, https://github.com/stnolting/neorv32
-- Auto-generated memory init file (for BOOTLOADER) from source file <riscv32_u2p_boot/result/bootloader.bin>
-- Size: 3120 bytes

library ieee;
use ieee.std_logic_1164.all;

library neorv32;
use neorv32.neorv32_package.all;

package neorv32_bootloader_image is

  constant bootloader_init_image : mem32_t := (
    00000000 => x"30047073",
    00000001 => x"80010117",
    00000002 => x"7fc10113",
    00000003 => x"80010197",
    00000004 => x"7f418193",
    00000005 => x"00000517",
    00000006 => x"0cc50513",
    00000007 => x"30551073",
    00000008 => x"34151073",
    00000009 => x"30001073",
    00000010 => x"30401073",
    00000011 => x"34401073",
    00000012 => x"32001073",
    00000013 => x"30601073",
    00000014 => x"b0001073",
    00000015 => x"b8001073",
    00000016 => x"b0201073",
    00000017 => x"b8201073",
    00000018 => x"00000093",
    00000019 => x"00000213",
    00000020 => x"00000293",
    00000021 => x"00000313",
    00000022 => x"00000393",
    00000023 => x"00010417",
    00000024 => x"da440413",
    00000025 => x"00010497",
    00000026 => x"f9c48493",
    00000027 => x"00042023",
    00000028 => x"00440413",
    00000029 => x"fe941ce3",
    00000030 => x"00001597",
    00000031 => x"bb858593",
    00000032 => x"80010617",
    00000033 => x"f8060613",
    00000034 => x"80010697",
    00000035 => x"f7868693",
    00000036 => x"00d65c63",
    00000037 => x"0005a703",
    00000038 => x"00e62023",
    00000039 => x"00458593",
    00000040 => x"00460613",
    00000041 => x"fedff06f",
    00000042 => x"80010717",
    00000043 => x"f5870713",
    00000044 => x"80818793",
    00000045 => x"00f75863",
    00000046 => x"00072023",
    00000047 => x"00470713",
    00000048 => x"ff5ff06f",
    00000049 => x"00000513",
    00000050 => x"00000593",
    00000051 => x"060000ef",
    00000052 => x"34051073",
    00000053 => x"30047073",
    00000054 => x"10500073",
    00000055 => x"0000006f",
    00000056 => x"ff810113",
    00000057 => x"00812023",
    00000058 => x"00912223",
    00000059 => x"34202473",
    00000060 => x"02044663",
    00000061 => x"34102473",
    00000062 => x"00041483",
    00000063 => x"0034f493",
    00000064 => x"00240413",
    00000065 => x"34141073",
    00000066 => x"00300413",
    00000067 => x"00941863",
    00000068 => x"34102473",
    00000069 => x"00240413",
    00000070 => x"34141073",
    00000071 => x"00012403",
    00000072 => x"00412483",
    00000073 => x"00810113",
    00000074 => x"30200073",
    00000075 => x"ff010113",
    00000076 => x"00112623",
    00000077 => x"00812423",
    00000078 => x"00912223",
    00000079 => x"131000ef",
    00000080 => x"00055663",
    00000081 => x"00030537",
    00000082 => x"078000ef",
    00000083 => x"02300513",
    00000084 => x"1a5000ef",
    00000085 => x"6a4000ef",
    00000086 => x"100607b7",
    00000087 => x"00100713",
    00000088 => x"20e78423",
    00000089 => x"00300713",
    00000090 => x"20e78023",
    00000091 => x"00a00713",
    00000092 => x"20e78023",
    00000093 => x"20078023",
    00000094 => x"20078023",
    00000095 => x"2007a503",
    00000096 => x"2007a483",
    00000097 => x"2007a403",
    00000098 => x"210000ef",
    00000099 => x"00048513",
    00000100 => x"208000ef",
    00000101 => x"00040513",
    00000102 => x"200000ef",
    00000103 => x"ffff1537",
    00000104 => x"b2450513",
    00000105 => x"0d4000ef",
    00000106 => x"100007b7",
    00000107 => x"02578793",
    00000108 => x"00100713",
    00000109 => x"00e78023",
    00000110 => x"00078023",
    00000111 => x"ff9ff06f",
    00000112 => x"00050067",
    00000113 => x"101007b7",
    00000114 => x"00300713",
    00000115 => x"10e78623",
    00000116 => x"10078023",
    00000117 => x"00400513",
    00000118 => x"10a780a3",
    00000119 => x"00200693",
    00000120 => x"10d78123",
    00000121 => x"10078023",
    00000122 => x"f8000713",
    00000123 => x"10e780a3",
    00000124 => x"10078123",
    00000125 => x"10078023",
    00000126 => x"fc000713",
    00000127 => x"10e780a3",
    00000128 => x"10078123",
    00000129 => x"05000593",
    00000130 => x"10b78023",
    00000131 => x"04400613",
    00000132 => x"10c780a3",
    00000133 => x"10078123",
    00000134 => x"10078023",
    00000135 => x"00100713",
    00000136 => x"10e780a3",
    00000137 => x"10078123",
    00000138 => x"10078023",
    00000139 => x"10a780a3",
    00000140 => x"10d78123",
    00000141 => x"10e78123",
    00000142 => x"10e78123",
    00000143 => x"10e78123",
    00000144 => x"10e78123",
    00000145 => x"03300713",
    00000146 => x"10e78023",
    00000147 => x"10d780a3",
    00000148 => x"10078123",
    00000149 => x"fd000713",
    00000150 => x"10e78023",
    00000151 => x"04700713",
    00000152 => x"10e780a3",
    00000153 => x"10078123",
    00000154 => x"10b78023",
    00000155 => x"10c780a3",
    00000156 => x"10078123",
    00000157 => x"00008067",
    00000158 => x"ff010113",
    00000159 => x"00812423",
    00000160 => x"00112623",
    00000161 => x"00050413",
    00000162 => x"00044503",
    00000163 => x"00051a63",
    00000164 => x"00c12083",
    00000165 => x"00812403",
    00000166 => x"01010113",
    00000167 => x"00008067",
    00000168 => x"00140413",
    00000169 => x"051000ef",
    00000170 => x"fe1ff06f",
    00000171 => x"ff010113",
    00000172 => x"00812423",
    00000173 => x"ffff1437",
    00000174 => x"c1c40413",
    00000175 => x"00455793",
    00000176 => x"00f407b3",
    00000177 => x"00912223",
    00000178 => x"00050493",
    00000179 => x"0007c503",
    00000180 => x"00f4f493",
    00000181 => x"00112623",
    00000182 => x"00940433",
    00000183 => x"019000ef",
    00000184 => x"00044503",
    00000185 => x"00812403",
    00000186 => x"00c12083",
    00000187 => x"00412483",
    00000188 => x"01010113",
    00000189 => x"0010006f",
    00000190 => x"ff010113",
    00000191 => x"02300513",
    00000192 => x"00112623",
    00000193 => x"7f0000ef",
    00000194 => x"101007b7",
    00000195 => x"00000513",
    00000196 => x"10378793",
    00000197 => x"00100613",
    00000198 => x"0c800693",
    00000199 => x"00c78023",
    00000200 => x"0007c703",
    00000201 => x"0ff77713",
    00000202 => x"00070e63",
    00000203 => x"0ff57513",
    00000204 => x"f7dff0ef",
    00000205 => x"00c12083",
    00000206 => x"00a00513",
    00000207 => x"01010113",
    00000208 => x"7b40006f",
    00000209 => x"00150513",
    00000210 => x"fcd51ae3",
    00000211 => x"00c12083",
    00000212 => x"01010113",
    00000213 => x"00008067",
    00000214 => x"ff010113",
    00000215 => x"00812423",
    00000216 => x"00050413",
    00000217 => x"00855513",
    00000218 => x"00112623",
    00000219 => x"00912223",
    00000220 => x"00058493",
    00000221 => x"f39ff0ef",
    00000222 => x"0ff47513",
    00000223 => x"f31ff0ef",
    00000224 => x"00812403",
    00000225 => x"00c12083",
    00000226 => x"00048513",
    00000227 => x"00412483",
    00000228 => x"01010113",
    00000229 => x"ee5ff06f",
    00000230 => x"ff010113",
    00000231 => x"00812423",
    00000232 => x"00050413",
    00000233 => x"01855513",
    00000234 => x"00112623",
    00000235 => x"f01ff0ef",
    00000236 => x"01045513",
    00000237 => x"0ff57513",
    00000238 => x"ef5ff0ef",
    00000239 => x"00845513",
    00000240 => x"0ff57513",
    00000241 => x"ee9ff0ef",
    00000242 => x"0ff47513",
    00000243 => x"ee1ff0ef",
    00000244 => x"00812403",
    00000245 => x"00c12083",
    00000246 => x"02000513",
    00000247 => x"01010113",
    00000248 => x"7140006f",
    00000249 => x"fd010113",
    00000250 => x"02812423",
    00000251 => x"03212023",
    00000252 => x"101007b7",
    00000253 => x"00700713",
    00000254 => x"02112623",
    00000255 => x"02912223",
    00000256 => x"01312e23",
    00000257 => x"01412c23",
    00000258 => x"01512a23",
    00000259 => x"01612823",
    00000260 => x"01712623",
    00000261 => x"80000937",
    00000262 => x"10e78623",
    00000263 => x"00090413",
    00000264 => x"00042503",
    00000265 => x"00090913",
    00000266 => x"f71ff0ef",
    00000267 => x"00042783",
    00000268 => x"00010737",
    00000269 => x"000306b7",
    00000270 => x"00178793",
    00000271 => x"00f42023",
    00000272 => x"01079793",
    00000273 => x"0107d793",
    00000274 => x"00f71023",
    00000275 => x"00178793",
    00000276 => x"01079793",
    00000277 => x"00270713",
    00000278 => x"0107d793",
    00000279 => x"fed716e3",
    00000280 => x"00000413",
    00000281 => x"00000493",
    00000282 => x"00010a37",
    00000283 => x"01300b13",
    00000284 => x"ffff1bb7",
    00000285 => x"ffff1ab7",
    00000286 => x"00141793",
    00000287 => x"00fa07b3",
    00000288 => x"0007d503",
    00000289 => x"00092783",
    00000290 => x"01041993",
    00000291 => x"0109d993",
    00000292 => x"00f987b3",
    00000293 => x"01079793",
    00000294 => x"0107d793",
    00000295 => x"02f50663",
    00000296 => x"029b4263",
    00000297 => x"b44b8593",
    00000298 => x"eb1ff0ef",
    00000299 => x"00092503",
    00000300 => x"b4ca8593",
    00000301 => x"00a98533",
    00000302 => x"01051513",
    00000303 => x"01055513",
    00000304 => x"e99ff0ef",
    00000305 => x"00148493",
    00000306 => x"00140413",
    00000307 => x"fb4416e3",
    00000308 => x"06048863",
    00000309 => x"ffff1537",
    00000310 => x"b5050513",
    00000311 => x"d9dff0ef",
    00000312 => x"00048513",
    00000313 => x"eb5ff0ef",
    00000314 => x"00a00513",
    00000315 => x"608000ef",
    00000316 => x"00042503",
    00000317 => x"ea5ff0ef",
    00000318 => x"00442503",
    00000319 => x"e9dff0ef",
    00000320 => x"00842503",
    00000321 => x"e95ff0ef",
    00000322 => x"00a00513",
    00000323 => x"5e8000ef",
    00000324 => x"00000513",
    00000325 => x"02c12083",
    00000326 => x"02812403",
    00000327 => x"02412483",
    00000328 => x"02012903",
    00000329 => x"01c12983",
    00000330 => x"01812a03",
    00000331 => x"01412a83",
    00000332 => x"01012b03",
    00000333 => x"00c12b83",
    00000334 => x"03010113",
    00000335 => x"00008067",
    00000336 => x"ffff1537",
    00000337 => x"b5c50513",
    00000338 => x"d31ff0ef",
    00000339 => x"00100513",
    00000340 => x"fc5ff06f",
    00000341 => x"ff010113",
    00000342 => x"00812423",
    00000343 => x"101007b7",
    00000344 => x"00112623",
    00000345 => x"00912223",
    00000346 => x"101006b7",
    00000347 => x"100783a3",
    00000348 => x"00000413",
    00000349 => x"07800793",
    00000350 => x"10268613",
    00000351 => x"00500593",
    00000352 => x"00b60023",
    00000353 => x"00000013",
    00000354 => x"00000013",
    00000355 => x"00000013",
    00000356 => x"10d6c703",
    00000357 => x"0ff77713",
    00000358 => x"00070463",
    00000359 => x"00140413",
    00000360 => x"fff78793",
    00000361 => x"fc079ee3",
    00000362 => x"101007b7",
    00000363 => x"1077c483",
    00000364 => x"0ff47513",
    00000365 => x"cf9ff0ef",
    00000366 => x"02f00513",
    00000367 => x"538000ef",
    00000368 => x"0ff4f493",
    00000369 => x"00048513",
    00000370 => x"ce5ff0ef",
    00000371 => x"02000513",
    00000372 => x"524000ef",
    00000373 => x"00848533",
    00000374 => x"00c12083",
    00000375 => x"00812403",
    00000376 => x"00412483",
    00000377 => x"01010113",
    00000378 => x"00008067",
    00000379 => x"fb010113",
    00000380 => x"04112623",
    00000381 => x"04812423",
    00000382 => x"04912223",
    00000383 => x"03512a23",
    00000384 => x"03612823",
    00000385 => x"03712623",
    00000386 => x"03812423",
    00000387 => x"03912223",
    00000388 => x"03a12023",
    00000389 => x"01b12e23",
    00000390 => x"05212023",
    00000391 => x"03312e23",
    00000392 => x"03412c23",
    00000393 => x"ba1ff0ef",
    00000394 => x"101007b7",
    00000395 => x"100784a3",
    00000396 => x"100780a3",
    00000397 => x"10078023",
    00000398 => x"00300713",
    00000399 => x"10e78123",
    00000400 => x"00a00513",
    00000401 => x"4b0000ef",
    00000402 => x"00300493",
    00000403 => x"00000a93",
    00000404 => x"00000413",
    00000405 => x"10100b37",
    00000406 => x"f8000d93",
    00000407 => x"00100b93",
    00000408 => x"16800c93",
    00000409 => x"00800d13",
    00000410 => x"fff00c13",
    00000411 => x"03048513",
    00000412 => x"484000ef",
    00000413 => x"03a00513",
    00000414 => x"47c000ef",
    00000415 => x"0ff4f593",
    00000416 => x"00359713",
    00000417 => x"01871713",
    00000418 => x"41875713",
    00000419 => x"00000913",
    00000420 => x"00000993",
    00000421 => x"00000a13",
    00000422 => x"10bb0693",
    00000423 => x"0ff97613",
    00000424 => x"012767b3",
    00000425 => x"00b12623",
    00000426 => x"00c12423",
    00000427 => x"00e12223",
    00000428 => x"0ff7f793",
    00000429 => x"10fb0423",
    00000430 => x"01b68023",
    00000431 => x"00068023",
    00000432 => x"01768023",
    00000433 => x"e91ff0ef",
    00000434 => x"10100737",
    00000435 => x"10b70693",
    00000436 => x"00812603",
    00000437 => x"00412703",
    00000438 => x"00c12583",
    00000439 => x"00000793",
    00000440 => x"03951063",
    00000441 => x"00198793",
    00000442 => x"01778c63",
    00000443 => x"4019d993",
    00000444 => x"413609b3",
    00000445 => x"0ff9fa93",
    00000446 => x"00058413",
    00000447 => x"00100a13",
    00000448 => x"00190913",
    00000449 => x"0da91663",
    00000450 => x"00a00513",
    00000451 => x"3e8000ef",
    00000452 => x"0c0a1463",
    00000453 => x"fff48493",
    00000454 => x"f5849ae3",
    00000455 => x"ffff1537",
    00000456 => x"b6850513",
    00000457 => x"b55ff0ef",
    00000458 => x"101007b7",
    00000459 => x"10078023",
    00000460 => x"00400713",
    00000461 => x"10e780a3",
    00000462 => x"00200713",
    00000463 => x"10e78123",
    00000464 => x"020a0463",
    00000465 => x"00341413",
    00000466 => x"01546433",
    00000467 => x"0ff47413",
    00000468 => x"10878423",
    00000469 => x"f8000713",
    00000470 => x"10e785a3",
    00000471 => x"100785a3",
    00000472 => x"00100713",
    00000473 => x"10e785a3",
    00000474 => x"101007b7",
    00000475 => x"03200713",
    00000476 => x"10e78023",
    00000477 => x"00200713",
    00000478 => x"10e780a3",
    00000479 => x"10078123",
    00000480 => x"10078023",
    00000481 => x"00400693",
    00000482 => x"10d780a3",
    00000483 => x"10e78123",
    00000484 => x"04c12083",
    00000485 => x"04812403",
    00000486 => x"04412483",
    00000487 => x"04012903",
    00000488 => x"03c12983",
    00000489 => x"03412a83",
    00000490 => x"03012b03",
    00000491 => x"02c12b83",
    00000492 => x"02812c03",
    00000493 => x"02412c83",
    00000494 => x"02012d03",
    00000495 => x"01c12d83",
    00000496 => x"000a0513",
    00000497 => x"03812a03",
    00000498 => x"05010113",
    00000499 => x"00008067",
    00000500 => x"00078993",
    00000501 => x"ec9ff06f",
    00000502 => x"ffff1537",
    00000503 => x"b7050513",
    00000504 => x"a99ff0ef",
    00000505 => x"03040513",
    00000506 => x"30c000ef",
    00000507 => x"030a8513",
    00000508 => x"304000ef",
    00000509 => x"f35ff06f",
    00000510 => x"fc010113",
    00000511 => x"00300713",
    00000512 => x"02112e23",
    00000513 => x"02812c23",
    00000514 => x"02912a23",
    00000515 => x"03212823",
    00000516 => x"03312623",
    00000517 => x"03412423",
    00000518 => x"03512223",
    00000519 => x"03612023",
    00000520 => x"01712e23",
    00000521 => x"01812c23",
    00000522 => x"01912a23",
    00000523 => x"01a12823",
    00000524 => x"01b12623",
    00000525 => x"101007b7",
    00000526 => x"10e78623",
    00000527 => x"10000737",
    00000528 => x"00a74783",
    00000529 => x"01879793",
    00000530 => x"4187d793",
    00000531 => x"fe07cae3",
    00000532 => x"975ff0ef",
    00000533 => x"02400513",
    00000534 => x"ffff19b7",
    00000535 => x"298000ef",
    00000536 => x"00000493",
    00000537 => x"00000413",
    00000538 => x"ffe00a93",
    00000539 => x"01900b13",
    00000540 => x"ffff1a37",
    00000541 => x"bb498993",
    00000542 => x"ffff1bb7",
    00000543 => x"ffff1c37",
    00000544 => x"ffff1cb7",
    00000545 => x"3e800513",
    00000546 => x"220000ef",
    00000547 => x"00050913",
    00000548 => x"02a00513",
    00000549 => x"07590063",
    00000550 => x"f9f90793",
    00000551 => x"1cfb6063",
    00000552 => x"00279793",
    00000553 => x"013787b3",
    00000554 => x"0007a783",
    00000555 => x"00078067",
    00000556 => x"b74c8513",
    00000557 => x"9c5ff0ef",
    00000558 => x"101007b7",
    00000559 => x"00100713",
    00000560 => x"10e78223",
    00000561 => x"06000913",
    00000562 => x"10100d37",
    00000563 => x"00100d93",
    00000564 => x"105d4503",
    00000565 => x"fff90913",
    00000566 => x"0ff57513",
    00000567 => x"9d1ff0ef",
    00000568 => x"02000513",
    00000569 => x"210000ef",
    00000570 => x"11bd02a3",
    00000571 => x"fe0912e3",
    00000572 => x"00a00513",
    00000573 => x"200000ef",
    00000574 => x"f8dff06f",
    00000575 => x"b90c0513",
    00000576 => x"979ff0ef",
    00000577 => x"101007b7",
    00000578 => x"10078223",
    00000579 => x"03000913",
    00000580 => x"10100d37",
    00000581 => x"00100d93",
    00000582 => x"106d4503",
    00000583 => x"fff90913",
    00000584 => x"0ff57513",
    00000585 => x"989ff0ef",
    00000586 => x"02000513",
    00000587 => x"1c8000ef",
    00000588 => x"11bd02a3",
    00000589 => x"fe0912e3",
    00000590 => x"fb9ff06f",
    00000591 => x"cb1ff0ef",
    00000592 => x"f45ff06f",
    00000593 => x"9b5ff0ef",
    00000594 => x"a9dff0ef",
    00000595 => x"f39ff06f",
    00000596 => x"9a9ff0ef",
    00000597 => x"f31ff06f",
    00000598 => x"101007b7",
    00000599 => x"0127c503",
    00000600 => x"0117cd03",
    00000601 => x"00010737",
    00000602 => x"0ff57513",
    00000603 => x"00851513",
    00000604 => x"0ffd7d13",
    00000605 => x"01a56d33",
    00000606 => x"10000793",
    00000607 => x"00072683",
    00000608 => x"fff78793",
    00000609 => x"fe079ce3",
    00000610 => x"101007b7",
    00000611 => x"0127c903",
    00000612 => x"0117c503",
    00000613 => x"0ff97913",
    00000614 => x"0ff57513",
    00000615 => x"00891913",
    00000616 => x"00a96933",
    00000617 => x"0107c503",
    00000618 => x"0ff57513",
    00000619 => x"901ff0ef",
    00000620 => x"02d00513",
    00000621 => x"140000ef",
    00000622 => x"41a90533",
    00000623 => x"01051513",
    00000624 => x"b4cb8593",
    00000625 => x"01055513",
    00000626 => x"991ff0ef",
    00000627 => x"eb9ff06f",
    00000628 => x"101007b7",
    00000629 => x"04000713",
    00000630 => x"10e785a3",
    00000631 => x"ea9ff06f",
    00000632 => x"101007b7",
    00000633 => x"00500713",
    00000634 => x"10e78223",
    00000635 => x"00100713",
    00000636 => x"10e782a3",
    00000637 => x"fff40413",
    00000638 => x"0ff47413",
    00000639 => x"00040513",
    00000640 => x"8adff0ef",
    00000641 => x"e81ff06f",
    00000642 => x"101007b7",
    00000643 => x"00100713",
    00000644 => x"10e78223",
    00000645 => x"10e782a3",
    00000646 => x"00140413",
    00000647 => x"fddff06f",
    00000648 => x"101007b7",
    00000649 => x"00400713",
    00000650 => x"10e78223",
    00000651 => x"00100713",
    00000652 => x"10e782a3",
    00000653 => x"fff48493",
    00000654 => x"0ff4f493",
    00000655 => x"00048513",
    00000656 => x"fc1ff06f",
    00000657 => x"101007b7",
    00000658 => x"10078223",
    00000659 => x"00100713",
    00000660 => x"10e782a3",
    00000661 => x"00148493",
    00000662 => x"fe1ff06f",
    00000663 => x"ba8a0513",
    00000664 => x"819ff0ef",
    00000665 => x"00090513",
    00000666 => x"e8dff06f",
    00000667 => x"10000737",
    00000668 => x"00c74783",
    00000669 => x"01879693",
    00000670 => x"00d74783",
    00000671 => x"00e74503",
    00000672 => x"00f74703",
    00000673 => x"0ff7f793",
    00000674 => x"01079793",
    00000675 => x"0ff77713",
    00000676 => x"00d7e7b3",
    00000677 => x"0ff57513",
    00000678 => x"00e7e7b3",
    00000679 => x"00851513",
    00000680 => x"00f56533",
    00000681 => x"00008067",
    00000682 => x"100007b7",
    00000683 => x"ff000693",
    00000684 => x"0127c703",
    00000685 => x"01871713",
    00000686 => x"41875713",
    00000687 => x"00075a63",
    00000688 => x"0107c503",
    00000689 => x"000788a3",
    00000690 => x"0ff57513",
    00000691 => x"00008067",
    00000692 => x"fff50513",
    00000693 => x"00a05c63",
    00000694 => x"00d78323",
    00000695 => x"0067c703",
    00000696 => x"0ff77713",
    00000697 => x"fe071ce3",
    00000698 => x"fc9ff06f",
    00000699 => x"ffe00513",
    00000700 => x"00008067",
    00000701 => x"80000737",
    00000702 => x"00472703",
    00000703 => x"00050793",
    00000704 => x"100006b7",
    00000705 => x"00070463",
    00000706 => x"00070067",
    00000707 => x"0126c703",
    00000708 => x"01077713",
    00000709 => x"fe071ce3",
    00000710 => x"0ff7f793",
    00000711 => x"00f68823",
    00000712 => x"00008067",
    00000713 => x"74696157",
    00000714 => x"20676e69",
    00000715 => x"20726f66",
    00000716 => x"4741544a",
    00000717 => x"776f6420",
    00000718 => x"616f6c6e",
    00000719 => x"0a0a2164",
    00000720 => x"00000000",
    00000721 => x"203d2120",
    00000722 => x"00000000",
    00000723 => x"0000000a",
    00000724 => x"204d4152",
    00000725 => x"6f727265",
    00000726 => x"000a2e72",
    00000727 => x"204d4152",
    00000728 => x"21214b4f",
    00000729 => x"0000000d",
    00000730 => x"4c494146",
    00000731 => x"00000000",
    00000732 => x"00004b4f",
    00000733 => x"7379530a",
    00000734 => x"636f6c43",
    00000735 => x"7376206b",
    00000736 => x"72744320",
    00000737 => x"6f6c436c",
    00000738 => x"0a3a6b63",
    00000739 => x"00000000",
    00000740 => x"4c43530a",
    00000741 => x"7376204b",
    00000742 => x"72744320",
    00000743 => x"6f6c436c",
    00000744 => x"0a3a6b63",
    00000745 => x"00000000",
    00000746 => x"6e6b6e55",
    00000747 => x"206e776f",
    00000748 => x"00000000",
    00000749 => x"ffff08b0",
    00000750 => x"ffff08fc",
    00000751 => x"ffff093c",
    00000752 => x"ffff0a5c",
    00000753 => x"ffff0a5c",
    00000754 => x"ffff0a5c",
    00000755 => x"ffff0a5c",
    00000756 => x"ffff0a5c",
    00000757 => x"ffff0a5c",
    00000758 => x"ffff0a5c",
    00000759 => x"ffff0a5c",
    00000760 => x"ffff0958",
    00000761 => x"ffff0a44",
    00000762 => x"ffff0a20",
    00000763 => x"ffff0a5c",
    00000764 => x"ffff0a5c",
    00000765 => x"ffff0a5c",
    00000766 => x"ffff0944",
    00000767 => x"ffff09d0",
    00000768 => x"ffff0950",
    00000769 => x"ffff0a5c",
    00000770 => x"ffff0a5c",
    00000771 => x"ffff0a5c",
    00000772 => x"ffff0a08",
    00000773 => x"ffff0a5c",
    00000774 => x"ffff09e0",
    00000775 => x"33323130",
    00000776 => x"37363534",
    00000777 => x"42413938",
    00000778 => x"46454443",
    00000779 => x"00000000"
  );

end neorv32_bootloader_image;
