FILENAME inc  "/data/CMSHCC/transport/C2419P1M";
LIBNAME incoef  "/data/CMSHCC/transport";

PROC CIMPORT data=incoef.hcccoefn infile=inc; run;

FILENAME inf  "/data/CMSHCC/transport/F2422P1M";
LIBNAME library  "/data/CMSHCC/transport";

PROC CIMPORT library=library infile=inf; run;

LIBNAME LIBRARY "/data/CMSHCC/transport";
FILENAME IN0 "/data/CMSHCC/programs";
LIBNAME  IN1 "/data/CMSHCC/input"; 
LIBNAME  IN2 "/data/CMSHCC/input";
LIBNAME  INCOEF "/data/CMSHCC/transport";
LIBNAME  OUT "/data/CMSHCC/output";

%LET INPUTVARS=%STR(SEX DOB LTIMCAID NEMCAID OREC);

%*demographic variables;
%LET DEMVARS  =%STR(AGEF ORIGDS DISABL
                    F0_34  F35_44 F45_54 F55_59 F60_64 F65_69
                    F70_74 F75_79 F80_84 F85_89 F90_94 F95_GT
                    M0_34  M35_44 M45_54 M55_59 M60_64 M65_69
                    M70_74 M75_79 M80_84 M85_89 M90_94 M95_GT
                    NEF0_34  NEF35_44 NEF45_54 NEF55_59 NEF60_64
                    NEF65    NEF66    NEF67    NEF68    NEF69
                    NEF70_74 NEF75_79 NEF80_84 NEF85_89 NEF90_94
                    NEF95_GT
                    NEM0_34  NEM35_44 NEM45_54 NEM55_59 NEM60_64
                    NEM65    NEM66    NEM67    NEM68    NEM69
                    NEM70_74 NEM75_79 NEM80_84 NEM85_89 NEM90_94
                    NEM95_GT);

%*list of HCCs included in models;
%LET HCCV24_list86 = %STR(      
    HCC1    HCC2    HCC6    HCC8    HCC9    HCC10   HCC11   HCC12
    HCC17   HCC18   HCC19   HCC21   HCC22   HCC23   HCC27   HCC28
    HCC29   HCC33   HCC34   HCC35   HCC39   HCC40   HCC46   HCC47
    HCC48   HCC51   HCC52   HCC54   HCC55   HCC56   HCC57   HCC58   
    HCC59   HCC60   HCC70   HCC71   HCC72   HCC73   HCC74   HCC75   
    HCC76   HCC77   HCC78   HCC79   HCC80   HCC82   HCC83   HCC84   
    HCC85   HCC86   HCC87   HCC88   HCC96   HCC99   HCC100  HCC103  
    HCC104  HCC106  HCC107  HCC108  HCC110  HCC111  HCC112  HCC114  
    HCC115  HCC122  HCC124  HCC134  HCC135  HCC136  HCC137  HCC138  
    HCC157  HCC158  HCC159  HCC161  HCC162  HCC166  HCC167  HCC169  
    HCC170  HCC173  HCC176  HCC186  HCC188  HCC189
    );

%*list of CCs that correspond to model HCCs;
%LET CCV24_list86 = %STR(      
    CC1     CC2     CC6     CC8     CC9     CC10    CC11    CC12
    CC17    CC18    CC19    CC21    CC22    CC23    CC27    CC28
    CC29    CC33    CC34    CC35    CC39    CC40    CC46    CC47
    CC48    CC51    CC52    CC54    CC55    CC56    CC57    CC58    
    CC59    CC60    CC70    CC71    CC72    CC73    CC74    CC75    
    CC76    CC77    CC78    CC79    CC80    CC82    CC83    CC84    
    CC85    CC86    CC87    CC88    CC96    CC99    CC100   CC103   
    CC104   CC106   CC107   CC108   CC110   CC111   CC112   CC114   
    CC115   CC122   CC124   CC134   CC135   CC136   CC137   CC138   
    CC157   CC158   CC159   CC161   CC162   CC166   CC167   CC169   
    CC170   CC173   CC176   CC186   CC188   CC189
    );

%LET SCOREVARS=%STR(SCORE_COMMUNITY_NA
                    SCORE_COMMUNITY_ND
                    SCORE_COMMUNITY_FBA
                    SCORE_COMMUNITY_FBD
                    SCORE_COMMUNITY_PBA
                    SCORE_COMMUNITY_PBD 
                    SCORE_INSTITUTIONAL
                    SCORE_NEW_ENROLLEE
                    SCORE_SNP_NEW_ENROLLEE
                    );

%* include main macro;
%INCLUDE IN0(V2422P1M)/SOURCE2;

%V2422P1M(  INP      =IN1.PERSON,
            IND      =IN2.DIAG,
            OUTDATA  =OUT.PERSON,
            IDVAR    =HICNO,
            KEEPVAR  =HICNO &INPUTVARS &SCOREVARS &DEMVARS 
                        &HCCV24_list86 &CCV24_list86, 
            SEDITS   =1,
            DATE_ASOF="1FEB2022"D);