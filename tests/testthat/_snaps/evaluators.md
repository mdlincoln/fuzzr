# snapshot tests from example

    Code
      as.data.frame(fr)
    Output
                           x output messages warnings errors result_classes
      1           char_empty   <NA>     <NA>     <NA>   <NA>      character
      2          char_single   <NA>     <NA>     <NA>   <NA>      character
      3    char_single_blank   <NA>     <NA>     <NA>   <NA>      character
      4        char_multiple   <NA>     <NA>     <NA>   <NA>      character
      5  char_multiple_blank   <NA>     <NA>     <NA>   <NA>      character
      6         char_with_na   <NA>     <NA>     <NA>   <NA>      character
      7       char_single_na   <NA>     <NA>     <NA>   <NA>      character
      8          char_all_na   <NA>     <NA>     <NA>   <NA>      character
      9            int_empty   <NA>     <NA>     <NA>   <NA>        integer
      10          int_single   <NA>     <NA>     <NA>   <NA>        integer
      11        int_multiple   <NA>     <NA>     <NA>   <NA>        integer
      12         int_with_na   <NA>     <NA>     <NA>   <NA>        integer
      13       int_single_na   <NA>     <NA>     <NA>   <NA>        integer
      14          int_all_na   <NA>     <NA>     <NA>   <NA>        integer
      15           dbl_empty   <NA>     <NA>     <NA>   <NA>        numeric
      16          dbl_single   <NA>     <NA>     <NA>   <NA>        numeric
      17        dbl_mutliple   <NA>     <NA>     <NA>   <NA>        numeric
      18         dbl_with_na   <NA>     <NA>     <NA>   <NA>        numeric
      19       dbl_single_na   <NA>     <NA>     <NA>   <NA>        numeric
      20          dbl_all_na   <NA>     <NA>     <NA>   <NA>        numeric
      21          fctr_empty   <NA>     <NA>     <NA>   <NA>         factor
      22         fctr_single   <NA>     <NA>     <NA>   <NA>         factor
      23       fctr_multiple   <NA>     <NA>     <NA>   <NA>         factor
      24        fctr_with_na   <NA>     <NA>     <NA>   <NA>         factor
      25 fctr_missing_levels   <NA>     <NA>     <NA>   <NA>         factor
      26      fctr_single_na   <NA>     <NA>     <NA>   <NA>         factor
      27         fctr_all_na   <NA>     <NA>     <NA>   <NA>         factor
      28           lgl_empty   <NA>     <NA>     <NA>   <NA>        logical
      29          lgl_single   <NA>     <NA>     <NA>   <NA>        logical
      30        lgl_mutliple   <NA>     <NA>     <NA>   <NA>        logical
      31         lgl_with_na   <NA>     <NA>     <NA>   <NA>        logical
      32       lgl_single_na   <NA>     <NA>     <NA>   <NA>        logical
      33          lgl_all_na   <NA>     <NA>     <NA>   <NA>        logical
      34         date_single   <NA>     <NA>     <NA>   <NA>           Date
      35       date_multiple   <NA>     <NA>     <NA>   <NA>           Date
      36        date_with_na   <NA>     <NA>     <NA>   <NA>           Date
      37      date_single_na   <NA>     <NA>     <NA>   <NA>           Date
      38         date_all_na   <NA>     <NA>     <NA>   <NA>           Date
      39           raw_empty   <NA>     <NA>     <NA>   <NA>            raw
      40            raw_char   <NA>     <NA>     <NA>   <NA>            raw
      41              raw_na   <NA>     <NA>     <NA>   <NA>            raw
      42         df_complete   <NA>     <NA>     <NA>   <NA>     data.frame
      43            df_empty   <NA>     <NA>     <NA>   <NA>     data.frame
      44          df_one_row   <NA>     <NA>     <NA>   <NA>     data.frame
      45          df_one_col   <NA>     <NA>     <NA>   <NA>        numeric
      46          df_with_na   <NA>     <NA>     <NA>   <NA>     data.frame
      47          null_value   <NA>     <NA>     <NA>   <NA>           <NA>
         results_index
      1              1
      2              2
      3              3
      4              4
      5              5
      6              6
      7              7
      8              8
      9              9
      10            10
      11            11
      12            12
      13            13
      14            14
      15            15
      16            16
      17            17
      18            18
      19            19
      20            20
      21            21
      22            22
      23            23
      24            24
      25            25
      26            26
      27            27
      28            28
      29            29
      30            30
      31            31
      32            32
      33            33
      34            34
      35            35
      36            36
      37            37
      38            38
      39            39
      40            40
      41            41
      42            42
      43            43
      44            44
      45            45
      46            46
      47            47

---

    Code
      as.data.frame(fr2)
    Output
                           x                   y output messages warnings errors
      1           char_empty                   y   <NA>     <NA>     <NA>   <NA>
      2          char_single                   y   <NA>     <NA>     <NA>   <NA>
      3    char_single_blank                   y   <NA>     <NA>     <NA>   <NA>
      4        char_multiple                   y   <NA>     <NA>     <NA>   <NA>
      5  char_multiple_blank                   y   <NA>     <NA>     <NA>   <NA>
      6         char_with_na                   y   <NA>     <NA>     <NA>   <NA>
      7       char_single_na                   y   <NA>     <NA>     <NA>   <NA>
      8          char_all_na                   y   <NA>     <NA>     <NA>   <NA>
      9            int_empty                   y   <NA>     <NA>     <NA>   <NA>
      10          int_single                   y   <NA>     <NA>     <NA>   <NA>
      11        int_multiple                   y   <NA>     <NA>     <NA>   <NA>
      12         int_with_na                   y   <NA>     <NA>     <NA>   <NA>
      13       int_single_na                   y   <NA>     <NA>     <NA>   <NA>
      14          int_all_na                   y   <NA>     <NA>     <NA>   <NA>
      15           dbl_empty                   y   <NA>     <NA>     <NA>   <NA>
      16          dbl_single                   y   <NA>     <NA>     <NA>   <NA>
      17        dbl_mutliple                   y   <NA>     <NA>     <NA>   <NA>
      18         dbl_with_na                   y   <NA>     <NA>     <NA>   <NA>
      19       dbl_single_na                   y   <NA>     <NA>     <NA>   <NA>
      20          dbl_all_na                   y   <NA>     <NA>     <NA>   <NA>
      21          fctr_empty                   y   <NA>     <NA>     <NA>   <NA>
      22         fctr_single                   y   <NA>     <NA>     <NA>   <NA>
      23       fctr_multiple                   y   <NA>     <NA>     <NA>   <NA>
      24        fctr_with_na                   y   <NA>     <NA>     <NA>   <NA>
      25 fctr_missing_levels                   y   <NA>     <NA>     <NA>   <NA>
      26      fctr_single_na                   y   <NA>     <NA>     <NA>   <NA>
      27         fctr_all_na                   y   <NA>     <NA>     <NA>   <NA>
      28           lgl_empty                   y   <NA>     <NA>     <NA>   <NA>
      29          lgl_single                   y   <NA>     <NA>     <NA>   <NA>
      30        lgl_mutliple                   y   <NA>     <NA>     <NA>   <NA>
      31         lgl_with_na                   y   <NA>     <NA>     <NA>   <NA>
      32       lgl_single_na                   y   <NA>     <NA>     <NA>   <NA>
      33          lgl_all_na                   y   <NA>     <NA>     <NA>   <NA>
      34         date_single                   y   <NA>     <NA>     <NA>   <NA>
      35       date_multiple                   y   <NA>     <NA>     <NA>   <NA>
      36        date_with_na                   y   <NA>     <NA>     <NA>   <NA>
      37      date_single_na                   y   <NA>     <NA>     <NA>   <NA>
      38         date_all_na                   y   <NA>     <NA>     <NA>   <NA>
      39           raw_empty                   y   <NA>     <NA>     <NA>   <NA>
      40            raw_char                   y   <NA>     <NA>     <NA>   <NA>
      41              raw_na                   y   <NA>     <NA>     <NA>   <NA>
      42         df_complete                   y   <NA>     <NA>     <NA>   <NA>
      43            df_empty                   y   <NA>     <NA>     <NA>   <NA>
      44          df_one_row                   y   <NA>     <NA>     <NA>   <NA>
      45          df_one_col                   y   <NA>     <NA>     <NA>   <NA>
      46          df_with_na                   y   <NA>     <NA>     <NA>   <NA>
      47          null_value                   y   <NA>     <NA>     <NA>   <NA>
      48                   x          char_empty   <NA>     <NA>     <NA>   <NA>
      49                   x         char_single   <NA>     <NA>     <NA>   <NA>
      50                   x   char_single_blank   <NA>     <NA>     <NA>   <NA>
      51                   x       char_multiple   <NA>     <NA>     <NA>   <NA>
      52                   x char_multiple_blank   <NA>     <NA>     <NA>   <NA>
      53                   x        char_with_na   <NA>     <NA>     <NA>   <NA>
      54                   x      char_single_na   <NA>     <NA>     <NA>   <NA>
      55                   x         char_all_na   <NA>     <NA>     <NA>   <NA>
      56                   x           int_empty   <NA>     <NA>     <NA>   <NA>
      57                   x          int_single   <NA>     <NA>     <NA>   <NA>
      58                   x        int_multiple   <NA>     <NA>     <NA>   <NA>
      59                   x         int_with_na   <NA>     <NA>     <NA>   <NA>
      60                   x       int_single_na   <NA>     <NA>     <NA>   <NA>
      61                   x          int_all_na   <NA>     <NA>     <NA>   <NA>
      62                   x           dbl_empty   <NA>     <NA>     <NA>   <NA>
      63                   x          dbl_single   <NA>     <NA>     <NA>   <NA>
      64                   x        dbl_mutliple   <NA>     <NA>     <NA>   <NA>
      65                   x         dbl_with_na   <NA>     <NA>     <NA>   <NA>
      66                   x       dbl_single_na   <NA>     <NA>     <NA>   <NA>
      67                   x          dbl_all_na   <NA>     <NA>     <NA>   <NA>
      68                   x          fctr_empty   <NA>     <NA>     <NA>   <NA>
      69                   x         fctr_single   <NA>     <NA>     <NA>   <NA>
      70                   x       fctr_multiple   <NA>     <NA>     <NA>   <NA>
      71                   x        fctr_with_na   <NA>     <NA>     <NA>   <NA>
      72                   x fctr_missing_levels   <NA>     <NA>     <NA>   <NA>
      73                   x      fctr_single_na   <NA>     <NA>     <NA>   <NA>
      74                   x         fctr_all_na   <NA>     <NA>     <NA>   <NA>
      75                   x           lgl_empty   <NA>     <NA>     <NA>   <NA>
      76                   x          lgl_single   <NA>     <NA>     <NA>   <NA>
      77                   x        lgl_mutliple   <NA>     <NA>     <NA>   <NA>
      78                   x         lgl_with_na   <NA>     <NA>     <NA>   <NA>
      79                   x       lgl_single_na   <NA>     <NA>     <NA>   <NA>
      80                   x          lgl_all_na   <NA>     <NA>     <NA>   <NA>
      81                   x         date_single   <NA>     <NA>     <NA>   <NA>
      82                   x       date_multiple   <NA>     <NA>     <NA>   <NA>
      83                   x        date_with_na   <NA>     <NA>     <NA>   <NA>
      84                   x      date_single_na   <NA>     <NA>     <NA>   <NA>
      85                   x         date_all_na   <NA>     <NA>     <NA>   <NA>
      86                   x           raw_empty   <NA>     <NA>     <NA>   <NA>
      87                   x            raw_char   <NA>     <NA>     <NA>   <NA>
      88                   x              raw_na   <NA>     <NA>     <NA>   <NA>
      89                   x         df_complete   <NA>     <NA>     <NA>   <NA>
      90                   x            df_empty   <NA>     <NA>     <NA>   <NA>
      91                   x          df_one_row   <NA>     <NA>     <NA>   <NA>
      92                   x          df_one_col   <NA>     <NA>     <NA>   <NA>
      93                   x          df_with_na   <NA>     <NA>     <NA>   <NA>
      94                   x          null_value   <NA>     <NA>     <NA>   <NA>
         result_classes results_index
      1         logical             1
      2         logical             2
      3         logical             3
      4         logical             4
      5         logical             5
      6         logical             6
      7         logical             7
      8         logical             8
      9         logical             9
      10        logical            10
      11        logical            11
      12        logical            12
      13        logical            13
      14        logical            14
      15        logical            15
      16        logical            16
      17        logical            17
      18        logical            18
      19        logical            19
      20        logical            20
      21        logical            21
      22        logical            22
      23        logical            23
      24        logical            24
      25        logical            25
      26        logical            26
      27        logical            27
      28        logical            28
      29        logical            29
      30        logical            30
      31        logical            31
      32        logical            32
      33        logical            33
      34        logical            34
      35        logical            35
      36        logical            36
      37        logical            37
      38        logical            38
      39        logical            39
      40        logical            40
      41        logical            41
      42        logical            42
      43        logical            43
      44        logical            44
      45        logical            45
      46        logical            46
      47        logical            47
      48        logical            48
      49        logical            49
      50        logical            50
      51        logical            51
      52        logical            52
      53        logical            53
      54        logical            54
      55        logical            55
      56        logical            56
      57        logical            57
      58        logical            58
      59        logical            59
      60        logical            60
      61        logical            61
      62        logical            62
      63        logical            63
      64        logical            64
      65        logical            65
      66        logical            66
      67        logical            67
      68        logical            68
      69        logical            69
      70        logical            70
      71        logical            71
      72        logical            72
      73        logical            73
      74        logical            74
      75        logical            75
      76        logical            76
      77        logical            77
      78        logical            78
      79        logical            79
      80        logical            80
      81        logical            81
      82        logical            82
      83        logical            83
      84        logical            84
      85        logical            85
      86        logical            86
      87        logical            87
      88        logical            88
      89        logical            89
      90        logical            90
      91        logical            91
      92        logical            92
      93        logical            93
      94        logical            94

---

    Code
      as.data.frame(fr3)
    Output
                        path output messages warnings
      1           char_empty   <NA>     <NA>     <NA>
      2          char_single   <NA>     <NA>     <NA>
      3    char_single_blank   <NA>     <NA>     <NA>
      4        char_multiple   <NA>     <NA>     <NA>
      5  char_multiple_blank   <NA>     <NA>     <NA>
      6         char_with_na   <NA>     <NA>     <NA>
      7       char_single_na   <NA>     <NA>     <NA>
      8          char_all_na   <NA>     <NA>     <NA>
      9            int_empty   <NA>     <NA>     <NA>
      10          int_single   <NA>     <NA>     <NA>
      11        int_multiple   <NA>     <NA>     <NA>
      12         int_with_na   <NA>     <NA>     <NA>
      13       int_single_na   <NA>     <NA>     <NA>
      14          int_all_na   <NA>     <NA>     <NA>
      15           dbl_empty   <NA>     <NA>     <NA>
      16          dbl_single   <NA>     <NA>     <NA>
      17        dbl_mutliple   <NA>     <NA>     <NA>
      18         dbl_with_na   <NA>     <NA>     <NA>
      19       dbl_single_na   <NA>     <NA>     <NA>
      20          dbl_all_na   <NA>     <NA>     <NA>
      21          fctr_empty   <NA>     <NA>     <NA>
      22         fctr_single   <NA>     <NA>     <NA>
      23       fctr_multiple   <NA>     <NA>     <NA>
      24        fctr_with_na   <NA>     <NA>     <NA>
      25 fctr_missing_levels   <NA>     <NA>     <NA>
      26      fctr_single_na   <NA>     <NA>     <NA>
      27         fctr_all_na   <NA>     <NA>     <NA>
      28           lgl_empty   <NA>     <NA>     <NA>
      29          lgl_single   <NA>     <NA>     <NA>
      30        lgl_mutliple   <NA>     <NA>     <NA>
      31         lgl_with_na   <NA>     <NA>     <NA>
      32       lgl_single_na   <NA>     <NA>     <NA>
      33          lgl_all_na   <NA>     <NA>     <NA>
      34         date_single   <NA>     <NA>     <NA>
      35       date_multiple   <NA>     <NA>     <NA>
      36        date_with_na   <NA>     <NA>     <NA>
      37      date_single_na   <NA>     <NA>     <NA>
      38         date_all_na   <NA>     <NA>     <NA>
      39           raw_empty   <NA>     <NA>     <NA>
      40            raw_char   <NA>     <NA>     <NA>
      41              raw_na   <NA>     <NA>     <NA>
      42         df_complete   <NA>     <NA>     <NA>
      43            df_empty   <NA>     <NA>     <NA>
      44          df_one_row   <NA>     <NA>     <NA>
      45          df_one_col   <NA>     <NA>     <NA>
      46          df_with_na   <NA>     <NA>     <NA>
      47          null_value   <NA>     <NA>     <NA>
                                       errors result_classes results_index
      1                                  <NA>      character             1
      2                                  <NA>      character             2
      3                                  <NA>      character             3
      4                                  <NA>      character             4
      5                                  <NA>      character             5
      6                                  <NA>      character             6
      7                                  <NA>      character             7
      8                                  <NA>      character             8
      9  a character vector argument expected           <NA>             9
      10 a character vector argument expected           <NA>            10
      11 a character vector argument expected           <NA>            11
      12 a character vector argument expected           <NA>            12
      13 a character vector argument expected           <NA>            13
      14 a character vector argument expected           <NA>            14
      15 a character vector argument expected           <NA>            15
      16 a character vector argument expected           <NA>            16
      17 a character vector argument expected           <NA>            17
      18 a character vector argument expected           <NA>            18
      19 a character vector argument expected           <NA>            19
      20 a character vector argument expected           <NA>            20
      21 a character vector argument expected           <NA>            21
      22 a character vector argument expected           <NA>            22
      23 a character vector argument expected           <NA>            23
      24 a character vector argument expected           <NA>            24
      25 a character vector argument expected           <NA>            25
      26 a character vector argument expected           <NA>            26
      27 a character vector argument expected           <NA>            27
      28 a character vector argument expected           <NA>            28
      29 a character vector argument expected           <NA>            29
      30 a character vector argument expected           <NA>            30
      31 a character vector argument expected           <NA>            31
      32 a character vector argument expected           <NA>            32
      33 a character vector argument expected           <NA>            33
      34 a character vector argument expected           <NA>            34
      35 a character vector argument expected           <NA>            35
      36 a character vector argument expected           <NA>            36
      37 a character vector argument expected           <NA>            37
      38 a character vector argument expected           <NA>            38
      39 a character vector argument expected           <NA>            39
      40 a character vector argument expected           <NA>            40
      41 a character vector argument expected           <NA>            41
      42 a character vector argument expected           <NA>            42
      43 a character vector argument expected           <NA>            43
      44 a character vector argument expected           <NA>            44
      45 a character vector argument expected           <NA>            45
      46 a character vector argument expected           <NA>            46
      47 a character vector argument expected           <NA>            47

---

    Code
      as.data.frame(fr4)
    Output
                        path output messages warnings
      1           char_empty   <NA>     <NA>     <NA>
      2          char_single   <NA>     <NA>     <NA>
      3    char_single_blank   <NA>     <NA>     <NA>
      4        char_multiple   <NA>     <NA>     <NA>
      5  char_multiple_blank   <NA>     <NA>     <NA>
      6         char_with_na   <NA>     <NA>     <NA>
      7       char_single_na   <NA>     <NA>     <NA>
      8          char_all_na   <NA>     <NA>     <NA>
      9            int_empty   <NA>     <NA>     <NA>
      10          int_single   <NA>     <NA>     <NA>
      11        int_multiple   <NA>     <NA>     <NA>
      12         int_with_na   <NA>     <NA>     <NA>
      13       int_single_na   <NA>     <NA>     <NA>
      14          int_all_na   <NA>     <NA>     <NA>
      15           dbl_empty   <NA>     <NA>     <NA>
      16          dbl_single   <NA>     <NA>     <NA>
      17        dbl_mutliple   <NA>     <NA>     <NA>
      18         dbl_with_na   <NA>     <NA>     <NA>
      19       dbl_single_na   <NA>     <NA>     <NA>
      20          dbl_all_na   <NA>     <NA>     <NA>
      21          fctr_empty   <NA>     <NA>     <NA>
      22         fctr_single   <NA>     <NA>     <NA>
      23       fctr_multiple   <NA>     <NA>     <NA>
      24        fctr_with_na   <NA>     <NA>     <NA>
      25 fctr_missing_levels   <NA>     <NA>     <NA>
      26      fctr_single_na   <NA>     <NA>     <NA>
      27         fctr_all_na   <NA>     <NA>     <NA>
      28           lgl_empty   <NA>     <NA>     <NA>
      29          lgl_single   <NA>     <NA>     <NA>
      30        lgl_mutliple   <NA>     <NA>     <NA>
      31         lgl_with_na   <NA>     <NA>     <NA>
      32       lgl_single_na   <NA>     <NA>     <NA>
      33          lgl_all_na   <NA>     <NA>     <NA>
      34         date_single   <NA>     <NA>     <NA>
      35       date_multiple   <NA>     <NA>     <NA>
      36        date_with_na   <NA>     <NA>     <NA>
      37      date_single_na   <NA>     <NA>     <NA>
      38         date_all_na   <NA>     <NA>     <NA>
      39           raw_empty   <NA>     <NA>     <NA>
      40            raw_char   <NA>     <NA>     <NA>
      41              raw_na   <NA>     <NA>     <NA>
      42         df_complete   <NA>     <NA>     <NA>
      43            df_empty   <NA>     <NA>     <NA>
      44          df_one_row   <NA>     <NA>     <NA>
      45          df_one_col   <NA>     <NA>     <NA>
      46          df_with_na   <NA>     <NA>     <NA>
      47          null_value   <NA>     <NA>     <NA>
                                       errors result_classes results_index
      1                                  <NA>      character             1
      2                                  <NA>      character             2
      3                                  <NA>      character             3
      4                                  <NA>      character             4
      5                                  <NA>      character             5
      6                                  <NA>      character             6
      7                                  <NA>      character             7
      8                                  <NA>      character             8
      9  a character vector argument expected           <NA>             9
      10 a character vector argument expected           <NA>            10
      11 a character vector argument expected           <NA>            11
      12 a character vector argument expected           <NA>            12
      13 a character vector argument expected           <NA>            13
      14 a character vector argument expected           <NA>            14
      15 a character vector argument expected           <NA>            15
      16 a character vector argument expected           <NA>            16
      17 a character vector argument expected           <NA>            17
      18 a character vector argument expected           <NA>            18
      19 a character vector argument expected           <NA>            19
      20 a character vector argument expected           <NA>            20
      21 a character vector argument expected           <NA>            21
      22 a character vector argument expected           <NA>            22
      23 a character vector argument expected           <NA>            23
      24 a character vector argument expected           <NA>            24
      25 a character vector argument expected           <NA>            25
      26 a character vector argument expected           <NA>            26
      27 a character vector argument expected           <NA>            27
      28 a character vector argument expected           <NA>            28
      29 a character vector argument expected           <NA>            29
      30 a character vector argument expected           <NA>            30
      31 a character vector argument expected           <NA>            31
      32 a character vector argument expected           <NA>            32
      33 a character vector argument expected           <NA>            33
      34 a character vector argument expected           <NA>            34
      35 a character vector argument expected           <NA>            35
      36 a character vector argument expected           <NA>            36
      37 a character vector argument expected           <NA>            37
      38 a character vector argument expected           <NA>            38
      39 a character vector argument expected           <NA>            39
      40 a character vector argument expected           <NA>            40
      41 a character vector argument expected           <NA>            41
      42 a character vector argument expected           <NA>            42
      43 a character vector argument expected           <NA>            43
      44 a character vector argument expected           <NA>            44
      45 a character vector argument expected           <NA>            45
      46 a character vector argument expected           <NA>            46
      47 a character vector argument expected           <NA>            47

