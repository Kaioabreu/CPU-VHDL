/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/ise/projeto_cpu/alu_mod.vhd";
extern char *WORK_P_3919810484;
extern char *IEEE_P_1242562249;
extern char *IEEE_P_2592010699;

char *ieee_p_1242562249_sub_3525738511873186323_1035706684(char *, char *, char *, char *, char *, char *);
char *ieee_p_1242562249_sub_3525738511873258197_1035706684(char *, char *, char *, char *, char *, char *);
char *ieee_p_2592010699_sub_16439767405979520975_503743352(char *, char *, char *, char *, char *, char *);
char *ieee_p_2592010699_sub_16439989832805790689_503743352(char *, char *, char *, char *, char *, char *);
char *ieee_p_2592010699_sub_16439989833707593767_503743352(char *, char *, char *, char *, char *, char *);
unsigned char ieee_p_2592010699_sub_3488768496604610246_503743352(char *, unsigned char , unsigned char );
unsigned char ieee_p_2592010699_sub_3488768497506413324_503743352(char *, unsigned char , unsigned char );
unsigned char ieee_p_2592010699_sub_374109322130769762_503743352(char *, unsigned char );


static void work_a_2823168985_3212880686_p_0(char *t0)
{
    char t19[16];
    char t49[16];
    char t50[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    int t6;
    int t7;
    int t8;
    char *t9;
    int t10;
    char *t11;
    int t12;
    char *t13;
    int t14;
    char *t15;
    int t16;
    char *t17;
    int t18;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned char t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned char t36;
    unsigned char t37;
    unsigned char t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned char t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned char t46;
    unsigned char t47;
    unsigned char t48;

LAB0:    xsi_set_current_line(51, ng0);
    t1 = (t0 + 4248);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(52, ng0);
    t1 = (t0 + 4312);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(54, ng0);
    t1 = (t0 + 1512U);
    t2 = *((char **)t1);
    t1 = ((WORK_P_3919810484) + 7288U);
    t3 = *((char **)t1);
    t6 = xsi_mem_cmp(t3, t2, 3U);
    if (t6 == 1)
        goto LAB3;

LAB12:    t1 = ((WORK_P_3919810484) + 7408U);
    t4 = *((char **)t1);
    t7 = xsi_mem_cmp(t4, t2, 3U);
    if (t7 == 1)
        goto LAB4;

LAB13:    t1 = ((WORK_P_3919810484) + 7528U);
    t5 = *((char **)t1);
    t8 = xsi_mem_cmp(t5, t2, 3U);
    if (t8 == 1)
        goto LAB5;

LAB14:    t1 = ((WORK_P_3919810484) + 7648U);
    t9 = *((char **)t1);
    t10 = xsi_mem_cmp(t9, t2, 3U);
    if (t10 == 1)
        goto LAB6;

LAB15:    t1 = ((WORK_P_3919810484) + 7768U);
    t11 = *((char **)t1);
    t12 = xsi_mem_cmp(t11, t2, 3U);
    if (t12 == 1)
        goto LAB7;

LAB16:    t1 = ((WORK_P_3919810484) + 7888U);
    t13 = *((char **)t1);
    t14 = xsi_mem_cmp(t13, t2, 3U);
    if (t14 == 1)
        goto LAB8;

LAB17:    t1 = ((WORK_P_3919810484) + 8008U);
    t15 = *((char **)t1);
    t16 = xsi_mem_cmp(t15, t2, 3U);
    if (t16 == 1)
        goto LAB9;

LAB18:    t1 = ((WORK_P_3919810484) + 8128U);
    t17 = *((char **)t1);
    t18 = xsi_mem_cmp(t17, t2, 3U);
    if (t18 == 1)
        goto LAB10;

LAB19:
LAB11:    xsi_set_current_line(86, ng0);
    t1 = xsi_get_transient_memory(16U);
    memset(t1, 0, 16U);
    t2 = t1;
    memset(t2, (unsigned char)2, 16U);
    t3 = (t0 + 4376);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t9 = (t5 + 56U);
    t11 = *((char **)t9);
    memcpy(t11, t1, 16U);
    xsi_driver_first_trans_fast(t3);

LAB2:    xsi_set_current_line(89, ng0);
    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t29 = (15 - 15);
    t30 = (t29 * 1U);
    t31 = (0 + t30);
    t1 = (t2 + t31);
    t3 = (t0 + 6583);
    t32 = 1;
    if (16U == 16U)
        goto LAB32;

LAB33:    t32 = 0;

LAB34:    if (t32 != 0)
        goto LAB29;

LAB31:    xsi_set_current_line(92, ng0);
    t1 = (t0 + 4440);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);

LAB30:    xsi_set_current_line(95, ng0);
    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t32 = *((unsigned char *)t2);
    t1 = (t0 + 4504);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t9 = *((char **)t5);
    *((unsigned char *)t9) = t32;
    xsi_driver_first_trans_delta(t1, 3U, 1, 0LL);
    xsi_set_current_line(96, ng0);
    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t6 = (15 - 15);
    t29 = (t6 * -1);
    t30 = (1U * t29);
    t31 = (0 + t30);
    t1 = (t2 + t31);
    t32 = *((unsigned char *)t1);
    t3 = (t0 + 4504);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t9 = (t5 + 56U);
    t11 = *((char **)t9);
    *((unsigned char *)t11) = t32;
    xsi_driver_first_trans_delta(t3, 2U, 1, 0LL);
    xsi_set_current_line(97, ng0);
    t1 = (t0 + 2312U);
    t2 = *((char **)t1);
    t32 = *((unsigned char *)t2);
    t1 = (t0 + 4504);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t9 = *((char **)t5);
    *((unsigned char *)t9) = t32;
    xsi_driver_first_trans_delta(t1, 1U, 1, 0LL);
    xsi_set_current_line(98, ng0);
    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t32 = *((unsigned char *)t2);
    t1 = (t0 + 4504);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t9 = *((char **)t5);
    *((unsigned char *)t9) = t32;
    xsi_driver_first_trans_delta(t1, 0U, 1, 0LL);
    t1 = (t0 + 4152);
    *((int *)t1) = 1;

LAB1:    return;
LAB3:    xsi_set_current_line(56, ng0);
    t1 = (t0 + 1032U);
    t20 = *((char **)t1);
    t1 = (t0 + 1040U);
    t21 = *((char **)t1);
    t22 = (t0 + 1192U);
    t23 = *((char **)t22);
    t22 = (t0 + 1200U);
    t24 = *((char **)t22);
    t25 = ieee_p_1242562249_sub_3525738511873186323_1035706684(IEEE_P_1242562249, t19, t20, t21, t23, t24);
    t26 = (t0 + 2608U);
    t27 = *((char **)t26);
    t26 = (t27 + 0);
    t28 = (t19 + 12U);
    t29 = *((unsigned int *)t28);
    t30 = (1U * t29);
    memcpy(t26, t25, t30);
    xsi_set_current_line(57, ng0);
    t1 = (t0 + 2608U);
    t2 = *((char **)t1);
    t29 = (16 - 15);
    t30 = (t29 * 1U);
    t31 = (0 + t30);
    t1 = (t2 + t31);
    t3 = (t0 + 4376);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t9 = (t5 + 56U);
    t11 = *((char **)t9);
    memcpy(t11, t1, 16U);
    xsi_driver_first_trans_fast(t3);
    xsi_set_current_line(58, ng0);
    t1 = (t0 + 2608U);
    t2 = *((char **)t1);
    t6 = (16 - 16);
    t29 = (t6 * -1);
    t30 = (1U * t29);
    t31 = (0 + t30);
    t1 = (t2 + t31);
    t32 = *((unsigned char *)t1);
    t3 = (t0 + 4248);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t9 = (t5 + 56U);
    t11 = *((char **)t9);
    *((unsigned char *)t11) = t32;
    xsi_driver_first_trans_fast(t3);
    xsi_set_current_line(59, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t6 = (15 - 15);
    t29 = (t6 * -1);
    t30 = (1U * t29);
    t31 = (0 + t30);
    t1 = (t2 + t31);
    t32 = *((unsigned char *)t1);
    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t7 = (15 - 15);
    t33 = (t7 * -1);
    t34 = (1U * t33);
    t35 = (0 + t34);
    t3 = (t4 + t35);
    t36 = *((unsigned char *)t3);
    t37 = ieee_p_2592010699_sub_3488768497506413324_503743352(IEEE_P_2592010699, t32, t36);
    t38 = ieee_p_2592010699_sub_374109322130769762_503743352(IEEE_P_2592010699, t37);
    t5 = (t0 + 1032U);
    t9 = *((char **)t5);
    t8 = (15 - 15);
    t39 = (t8 * -1);
    t40 = (1U * t39);
    t41 = (0 + t40);
    t5 = (t9 + t41);
    t42 = *((unsigned char *)t5);
    t11 = (t0 + 2608U);
    t13 = *((char **)t11);
    t10 = (15 - 16);
    t43 = (t10 * -1);
    t44 = (1U * t43);
    t45 = (0 + t44);
    t11 = (t13 + t45);
    t46 = *((unsigned char *)t11);
    t47 = ieee_p_2592010699_sub_3488768497506413324_503743352(IEEE_P_2592010699, t42, t46);
    t48 = ieee_p_2592010699_sub_3488768496604610246_503743352(IEEE_P_2592010699, t38, t47);
    t15 = (t0 + 4312);
    t17 = (t15 + 56U);
    t20 = *((char **)t17);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = t48;
    xsi_driver_first_trans_fast(t15);
    goto LAB2;

LAB4:    xsi_set_current_line(62, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t1 = (t0 + 1040U);
    t3 = *((char **)t1);
    t4 = (t0 + 1192U);
    t5 = *((char **)t4);
    t4 = (t0 + 1200U);
    t9 = *((char **)t4);
    t11 = ieee_p_1242562249_sub_3525738511873258197_1035706684(IEEE_P_1242562249, t19, t2, t3, t5, t9);
    t13 = (t0 + 2608U);
    t15 = *((char **)t13);
    t13 = (t15 + 0);
    t17 = (t19 + 12U);
    t29 = *((unsigned int *)t17);
    t30 = (1U * t29);
    memcpy(t13, t11, t30);
    xsi_set_current_line(63, ng0);
    t1 = (t0 + 2608U);
    t2 = *((char **)t1);
    t29 = (16 - 15);
    t30 = (t29 * 1U);
    t31 = (0 + t30);
    t1 = (t2 + t31);
    t3 = (t0 + 4376);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t9 = (t5 + 56U);
    t11 = *((char **)t9);
    memcpy(t11, t1, 16U);
    xsi_driver_first_trans_fast(t3);
    xsi_set_current_line(64, ng0);
    t1 = (t0 + 2608U);
    t2 = *((char **)t1);
    t6 = (16 - 16);
    t29 = (t6 * -1);
    t30 = (1U * t29);
    t31 = (0 + t30);
    t1 = (t2 + t31);
    t32 = *((unsigned char *)t1);
    t3 = (t0 + 4248);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t9 = (t5 + 56U);
    t11 = *((char **)t9);
    *((unsigned char *)t11) = t32;
    xsi_driver_first_trans_fast(t3);
    xsi_set_current_line(65, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t6 = (15 - 15);
    t29 = (t6 * -1);
    t30 = (1U * t29);
    t31 = (0 + t30);
    t1 = (t2 + t31);
    t32 = *((unsigned char *)t1);
    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t7 = (15 - 15);
    t33 = (t7 * -1);
    t34 = (1U * t33);
    t35 = (0 + t34);
    t3 = (t4 + t35);
    t36 = *((unsigned char *)t3);
    t37 = ieee_p_2592010699_sub_3488768497506413324_503743352(IEEE_P_2592010699, t32, t36);
    t5 = (t0 + 1032U);
    t9 = *((char **)t5);
    t8 = (15 - 15);
    t39 = (t8 * -1);
    t40 = (1U * t39);
    t41 = (0 + t40);
    t5 = (t9 + t41);
    t38 = *((unsigned char *)t5);
    t11 = (t0 + 2608U);
    t13 = *((char **)t11);
    t10 = (15 - 16);
    t43 = (t10 * -1);
    t44 = (1U * t43);
    t45 = (0 + t44);
    t11 = (t13 + t45);
    t42 = *((unsigned char *)t11);
    t46 = ieee_p_2592010699_sub_3488768497506413324_503743352(IEEE_P_2592010699, t38, t42);
    t47 = ieee_p_2592010699_sub_3488768496604610246_503743352(IEEE_P_2592010699, t37, t46);
    t15 = (t0 + 4312);
    t17 = (t15 + 56U);
    t20 = *((char **)t17);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = t47;
    xsi_driver_first_trans_fast(t15);
    goto LAB2;

LAB5:    xsi_set_current_line(68, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t1 = (t0 + 4376);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t9 = *((char **)t5);
    memcpy(t9, t2, 16U);
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB6:    xsi_set_current_line(71, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t29 = (15 - 7);
    t30 = (t29 * 1U);
    t31 = (0 + t30);
    t1 = (t2 + t31);
    t3 = (t0 + 1032U);
    t4 = *((char **)t3);
    t33 = (15 - 7);
    t34 = (t33 * 1U);
    t35 = (0 + t34);
    t3 = (t4 + t35);
    t9 = ((IEEE_P_2592010699) + 4000);
    t11 = (t49 + 0U);
    t13 = (t11 + 0U);
    *((int *)t13) = 7;
    t13 = (t11 + 4U);
    *((int *)t13) = 0;
    t13 = (t11 + 8U);
    *((int *)t13) = -1;
    t6 = (0 - 7);
    t39 = (t6 * -1);
    t39 = (t39 + 1);
    t13 = (t11 + 12U);
    *((unsigned int *)t13) = t39;
    t13 = (t50 + 0U);
    t15 = (t13 + 0U);
    *((int *)t15) = 7;
    t15 = (t13 + 4U);
    *((int *)t15) = 0;
    t15 = (t13 + 8U);
    *((int *)t15) = -1;
    t7 = (0 - 7);
    t39 = (t7 * -1);
    t39 = (t39 + 1);
    t15 = (t13 + 12U);
    *((unsigned int *)t15) = t39;
    t5 = xsi_base_array_concat(t5, t19, t9, (char)97, t1, t49, (char)97, t3, t50, (char)101);
    t39 = (8U + 8U);
    t32 = (16U != t39);
    if (t32 == 1)
        goto LAB21;

LAB22:    t15 = (t0 + 4376);
    t17 = (t15 + 56U);
    t20 = *((char **)t17);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    memcpy(t22, t5, 16U);
    xsi_driver_first_trans_fast(t15);
    goto LAB2;

LAB7:    goto LAB2;

LAB8:    xsi_set_current_line(77, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t1 = (t0 + 1040U);
    t3 = *((char **)t1);
    t4 = (t0 + 1192U);
    t5 = *((char **)t4);
    t4 = (t0 + 1200U);
    t9 = *((char **)t4);
    t11 = ieee_p_2592010699_sub_16439989832805790689_503743352(IEEE_P_2592010699, t19, t2, t3, t5, t9);
    t13 = (t19 + 12U);
    t29 = *((unsigned int *)t13);
    t30 = (1U * t29);
    t32 = (16U != t30);
    if (t32 == 1)
        goto LAB23;

LAB24:    t15 = (t0 + 4376);
    t17 = (t15 + 56U);
    t20 = *((char **)t17);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    memcpy(t22, t11, 16U);
    xsi_driver_first_trans_fast(t15);
    goto LAB2;

LAB9:    xsi_set_current_line(80, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t1 = (t0 + 1040U);
    t3 = *((char **)t1);
    t4 = (t0 + 1192U);
    t5 = *((char **)t4);
    t4 = (t0 + 1200U);
    t9 = *((char **)t4);
    t11 = ieee_p_2592010699_sub_16439767405979520975_503743352(IEEE_P_2592010699, t19, t2, t3, t5, t9);
    t13 = (t19 + 12U);
    t29 = *((unsigned int *)t13);
    t30 = (1U * t29);
    t32 = (16U != t30);
    if (t32 == 1)
        goto LAB25;

LAB26:    t15 = (t0 + 4376);
    t17 = (t15 + 56U);
    t20 = *((char **)t17);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    memcpy(t22, t11, 16U);
    xsi_driver_first_trans_fast(t15);
    goto LAB2;

LAB10:    xsi_set_current_line(83, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t1 = (t0 + 1040U);
    t3 = *((char **)t1);
    t4 = (t0 + 1192U);
    t5 = *((char **)t4);
    t4 = (t0 + 1200U);
    t9 = *((char **)t4);
    t11 = ieee_p_2592010699_sub_16439989833707593767_503743352(IEEE_P_2592010699, t19, t2, t3, t5, t9);
    t13 = (t19 + 12U);
    t29 = *((unsigned int *)t13);
    t30 = (1U * t29);
    t32 = (16U != t30);
    if (t32 == 1)
        goto LAB27;

LAB28:    t15 = (t0 + 4376);
    t17 = (t15 + 56U);
    t20 = *((char **)t17);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    memcpy(t22, t11, 16U);
    xsi_driver_first_trans_fast(t15);
    goto LAB2;

LAB20:;
LAB21:    xsi_size_not_matching(16U, t39, 0);
    goto LAB22;

LAB23:    xsi_size_not_matching(16U, t30, 0);
    goto LAB24;

LAB25:    xsi_size_not_matching(16U, t30, 0);
    goto LAB26;

LAB27:    xsi_size_not_matching(16U, t30, 0);
    goto LAB28;

LAB29:    xsi_set_current_line(90, ng0);
    t11 = (t0 + 4440);
    t13 = (t11 + 56U);
    t15 = *((char **)t13);
    t17 = (t15 + 56U);
    t20 = *((char **)t17);
    *((unsigned char *)t20) = (unsigned char)3;
    xsi_driver_first_trans_fast(t11);
    goto LAB30;

LAB32:    t33 = 0;

LAB35:    if (t33 < 16U)
        goto LAB36;
    else
        goto LAB34;

LAB36:    t5 = (t1 + t33);
    t9 = (t3 + t33);
    if (*((unsigned char *)t5) != *((unsigned char *)t9))
        goto LAB33;

LAB37:    t33 = (t33 + 1);
    goto LAB35;

}

static void work_a_2823168985_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(102, ng0);

LAB3:    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t1 = (t0 + 4568);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 16U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 4168);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_2823168985_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2823168985_3212880686_p_0,(void *)work_a_2823168985_3212880686_p_1};
	xsi_register_didat("work_a_2823168985_3212880686", "isim/testbench_isim_beh.exe.sim/work/a_2823168985_3212880686.didat");
	xsi_register_executes(pe);
}
