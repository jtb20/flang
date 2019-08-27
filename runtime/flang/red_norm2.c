/*
 * Copyright (c) 2019, NVIDIA CORPORATION.  All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

/* red_norm2.c -- intrinsic reduction function */

#include "norm2.h"

void F90_I8(stride_1_norm2_real4) (__POINT_T *src_pointer, __INT_T *size, __REAL4_T *result) {
    F90_I8(norm2_real4) (src_pointer, size, result);
}

void F90_I8(stride_1_norm2_real8) (__POINT_T *src_pointer, __INT_T *size, __REAL8_T *result) {
    F90_I8(norm2_real8) (src_pointer, size, result);
}

void ENTFTN(NORM2_NODIM, norm2_nodim) (__POINT_T *result, __POINT_T *src, __INT4_T * pfr, _DIST_TYPE *result_kind, F90_Desc *src_desc) {
  char error_msg[50];

  if (src_desc->kind == __REAL8) {
    switch(src_desc->rank) {
      case 1:
        F90_NORM2(nodim_1_real8) (result, src, pfr, src_desc);
        break;
      case 2:
        F90_NORM2(nodim_2_real8) (result, src, pfr, src_desc);
        break;
      case 3:
        F90_NORM2(nodim_3_real8) (result, src, pfr, src_desc);
        break;
      case 4:
        F90_NORM2(nodim_4_real8) (result, src, pfr, src_desc);
        break;
      case 5:
        F90_NORM2(nodim_5_real8) (result, src, pfr, src_desc);
        break;
      case 6:
        F90_NORM2(nodim_6_real8) (result, src, pfr, src_desc);
        break;
      case 7:
        F90_NORM2(nodim_7_real8) (result, src, pfr, src_desc);
        break;
      default:
        sprintf(error_msg, "Rank : %d, can not be less than 1 or greater 7\n", src_desc->rank);
        __fort_abort(error_msg);
    }
  } else if (src_desc->kind == __REAL4) {
    switch(src_desc->rank) {
      case 1:
        F90_NORM2(nodim_1_real4) (result, src, src_desc);
        break;
      case 2:
        F90_NORM2(nodim_2_real4) (result, src, src_desc);
        break;
      case 3:
        F90_NORM2(nodim_3_real4) (result, src, src_desc);
        break;
      case 4:
        F90_NORM2(nodim_4_real4) (result, src, src_desc);
        break;
      case 5:
        F90_NORM2(nodim_5_real4) (result, src, src_desc);
        break;
      case 6:
        F90_NORM2(nodim_6_real4) (result, src, src_desc);
        break;
      case 7:
        F90_NORM2(nodim_7_real4) (result, src, src_desc);
        break;
      default:
        sprintf(error_msg, "Rank : %d, can not be less than 1 or greater 7\n", src_desc->rank);
        __fort_abort(error_msg);
    }
  } else if (src_desc->len == 0) {
    // empty array case
    *result = 0.0;
  } else {
    sprintf(error_msg, "Unsupported type %d for norm2\n", src_desc->kind);
    __fort_abort(error_msg);
  }
}

void ENTFTN(NORM2, norm2) (__POINT_T *result, __POINT_T *src, __INT4_T * pfr, __INT4_T *dim, F90_Desc *result_desc, F90_Desc *src_desc) {
  char error_msg[50];

  if (0 >= *dim || *dim > src_desc->rank) {
    sprintf(error_msg, "DIM : %d, illegal dim value\n", *dim);
    __fort_abort(error_msg);
  }
  if (src_desc->kind == __REAL8) {
    switch (src_desc->rank) {
      case 1:
        F90_NORM2(nodim_1_real8) (result, src, pfr, src_desc);
        break;
      case 2:
        F90_NORM2(dim_2_real8) (result, src, pfr, dim, result_desc, src_desc);
        break;
      case 3:
        F90_NORM2(dim_3_real8) (result, src, pfr, dim, result_desc, src_desc);
        break;
      case 4:
        F90_NORM2(dim_4_real8) (result, src, pfr, dim, result_desc, src_desc);
        break;
      case 5:
        F90_NORM2(dim_5_real8) (result, src, pfr, dim, result_desc, src_desc);
        break;
      case 6:
        F90_NORM2(dim_6_real8) (result, src, pfr, dim, result_desc, src_desc);
        break;
      case 7:
        F90_NORM2(dim_7_real8) (result, src, pfr, dim, result_desc, src_desc);
        break;
      default:
        sprintf(error_msg, "Rank : %d, can not be less than 1 or greater 7\n", src_desc->rank);
        __fort_abort(error_msg);
    }
  } else if (src_desc->kind == __REAL4) {
    switch (src_desc->rank) {
      case 1:
        F90_NORM2(nodim_1_real4) (result, src, src_desc);
        break;
      case 2:
        F90_NORM2(dim_2_real4) (result, src, dim, result_desc, src_desc);
        break;
      case 3:
        F90_NORM2(dim_3_real4) (result, src, dim, result_desc, src_desc);
        break;
      case 4:
        F90_NORM2(dim_4_real4) (result, src, dim, result_desc, src_desc);
        break;
      case 5:
        F90_NORM2(dim_5_real4) (result, src, dim, result_desc, src_desc);
        break;
      case 6:
        F90_NORM2(dim_6_real4) (result, src, dim, result_desc, src_desc);
        break;
      case 7:
        F90_NORM2(dim_7_real4) (result, src, dim, result_desc, src_desc);
        break;
      default:
        sprintf(error_msg, "Rank : %d, can not be less than 1 or greater 7\n", src_desc->rank);
        __fort_abort(error_msg);
    }
  } else if (src_desc->len == 0) {
    // empty array case
    *result = 0.0;
  } else {
    sprintf(error_msg, "Unsupported type %d for norm2\n", src_desc->kind);
    __fort_abort(error_msg);
  }
}
