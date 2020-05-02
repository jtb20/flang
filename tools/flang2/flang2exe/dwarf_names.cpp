/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 */

/** \file
 * \brief Converting DWARF symbolic identifiers to textual form.
 */

#include "gbldefs.h"
#include "dwarf2.h"

#define CASERET(X) \
  case X:          \
    return #X

/** \brief Convert a DW_TAG_* constant to the corresponding string.
 *
 * The contents of this function was generated by the following vim command:
 *
 *   :read !awk '/define DW_TAG_/ { printf "        CASERET(\%s);\n", $2 }'
 * dwarf2.h
 */
const char *
dwarf_tag_name(unsigned value)
{
  switch (value) {
    CASERET(DW_TAG_padding);
    CASERET(DW_TAG_array_type);
    CASERET(DW_TAG_class_type);
    CASERET(DW_TAG_entry_point);
    CASERET(DW_TAG_enumeration_type);
    CASERET(DW_TAG_formal_parameter);
    CASERET(DW_TAG_imported_declaration);
    CASERET(DW_TAG_label);
    CASERET(DW_TAG_lexical_block);
    CASERET(DW_TAG_member);
    CASERET(DW_TAG_pointer_type);
    CASERET(DW_TAG_reference_type);
    CASERET(DW_TAG_compile_unit);
    CASERET(DW_TAG_string_type);
    CASERET(DW_TAG_structure_type);
    CASERET(DW_TAG_subroutine_type);
    CASERET(DW_TAG_typedef);
    CASERET(DW_TAG_union_type);
    CASERET(DW_TAG_unspecified_parameters);
    CASERET(DW_TAG_variant);
    CASERET(DW_TAG_common_block);
    CASERET(DW_TAG_common_inclusion);
    CASERET(DW_TAG_inheritance);
    CASERET(DW_TAG_inlined_subroutine);
    CASERET(DW_TAG_module);
    CASERET(DW_TAG_ptr_to_member_type);
    CASERET(DW_TAG_set_type);
    CASERET(DW_TAG_subrange_type);
    CASERET(DW_TAG_with_stmt);
    CASERET(DW_TAG_access_declaration);
    CASERET(DW_TAG_base_type);
    CASERET(DW_TAG_catch_block);
    CASERET(DW_TAG_const_type);
    CASERET(DW_TAG_constant);
    CASERET(DW_TAG_enumerator);
    CASERET(DW_TAG_file_type);
    CASERET(DW_TAG_friend);
    CASERET(DW_TAG_namelist);
    CASERET(DW_TAG_namelist_item);
    CASERET(DW_TAG_packed_type);
    CASERET(DW_TAG_subprogram);
    CASERET(DW_TAG_template_type_param);
    CASERET(DW_TAG_template_value_param);
    CASERET(DW_TAG_thrown_type);
    CASERET(DW_TAG_try_block);
    CASERET(DW_TAG_variant_part);
    CASERET(DW_TAG_variable);
    CASERET(DW_TAG_volatile_type);
    CASERET(DW_TAG_dwarf_procedure);
    CASERET(DW_TAG_restrict_type);
    CASERET(DW_TAG_interface_type);
    CASERET(DW_TAG_namespace);
    CASERET(DW_TAG_imported_module);
    CASERET(DW_TAG_unspecified_type);
    CASERET(DW_TAG_partial_unit);
    CASERET(DW_TAG_imported_unit);
    CASERET(DW_TAG_condition);
    CASERET(DW_TAG_shared_type);

    /* LLVM extension: Only valid in LLVM metadata. */
    CASERET(DW_TAG_auto_variable);
    CASERET(DW_TAG_arg_variable);

    CASERET(DW_TAG_MIPS_loop);
    CASERET(DW_TAG_HP_array_descriptor);
    CASERET(DW_TAG_format_label);
    CASERET(DW_TAG_function_template);
    CASERET(DW_TAG_class_template);
    CASERET(DW_TAG_GNU_BINCL);
    CASERET(DW_TAG_GNU_EINCL);
    CASERET(DW_TAG_upc_shared_type);
    CASERET(DW_TAG_upc_strict_type);
    CASERET(DW_TAG_upc_relaxed_type);
    CASERET(DW_TAG_kanji_type);
    CASERET(DW_TAG_interface_block);
  }

  if (value >= DW_TAG_lo_user && value < DW_TAG_hi_user)
    return "DW_TAG_<user_defined>";

  return "DW_TAG_<unknown>";
}

const char *
dwarf_attr_name(unsigned value)
{
  switch (value) {
    CASERET(DW_AT_sibling);
    CASERET(DW_AT_location);
    CASERET(DW_AT_name);
    CASERET(DW_AT_ordering);
    CASERET(DW_AT_subscr_data);
    CASERET(DW_AT_byte_size);
    CASERET(DW_AT_bit_offset);
    CASERET(DW_AT_bit_size);
    CASERET(DW_AT_element_list);
    CASERET(DW_AT_stmt_list);
    CASERET(DW_AT_low_pc);
    CASERET(DW_AT_high_pc);
    CASERET(DW_AT_language);
    CASERET(DW_AT_member);
    CASERET(DW_AT_discr);
    CASERET(DW_AT_discr_value);
    CASERET(DW_AT_visibility);
    CASERET(DW_AT_import);
    CASERET(DW_AT_string_length);
    CASERET(DW_AT_common_reference);
    CASERET(DW_AT_comp_dir);
    CASERET(DW_AT_const_value);
    CASERET(DW_AT_containing_type);
    CASERET(DW_AT_default_value);
    CASERET(DW_AT_inline);
    CASERET(DW_AT_is_optional);
    CASERET(DW_AT_lower_bound);
    CASERET(DW_AT_producer);
    CASERET(DW_AT_prototyped);
    CASERET(DW_AT_return_addr);
    CASERET(DW_AT_start_scope);
    CASERET(DW_AT_stride_size);
    CASERET(DW_AT_upper_bound);
    CASERET(DW_AT_abstract_origin);
    CASERET(DW_AT_accessibility);
    CASERET(DW_AT_address_class);
    CASERET(DW_AT_artificial);
    CASERET(DW_AT_base_types);
    CASERET(DW_AT_calling_convention);
    CASERET(DW_AT_count);
    CASERET(DW_AT_data_member_location);
    CASERET(DW_AT_decl_column);
    CASERET(DW_AT_decl_file);
    CASERET(DW_AT_decl_line);
    CASERET(DW_AT_declaration);
    CASERET(DW_AT_discr_list);
    CASERET(DW_AT_encoding);
    CASERET(DW_AT_external);
    CASERET(DW_AT_frame_base);
    CASERET(DW_AT_friend);
    CASERET(DW_AT_identifier_case);
    CASERET(DW_AT_macro_info);
    CASERET(DW_AT_namelist_item);
    CASERET(DW_AT_priority);
    CASERET(DW_AT_segment);
    CASERET(DW_AT_specification);
    CASERET(DW_AT_static_link);
    CASERET(DW_AT_type);
    CASERET(DW_AT_use_location);
    CASERET(DW_AT_variable_parameter);
    CASERET(DW_AT_virtuality);
    CASERET(DW_AT_vtable_elem_location);
    /* See DW_AT_stride_size: CASERET(DW_AT_bit_stride); */
    CASERET(DW_AT_allocated);
    CASERET(DW_AT_associated);
    CASERET(DW_AT_data_location);
    CASERET(DW_AT_stride);
    /* See DW_AT_stride: CASERET(DW_AT_byte_stride); */
    CASERET(DW_AT_entry_pc);
    CASERET(DW_AT_use_UTF8);
    CASERET(DW_AT_extension);
    CASERET(DW_AT_ranges);
    CASERET(DW_AT_trampoline);
    CASERET(DW_AT_call_column);
    CASERET(DW_AT_call_file);
    CASERET(DW_AT_call_line);
    CASERET(DW_AT_description);
    CASERET(DW_AT_binary_scale);
    CASERET(DW_AT_decimal_scale);
    CASERET(DW_AT_small);
    CASERET(DW_AT_decimal_sign);
    CASERET(DW_AT_digit_count);
    CASERET(DW_AT_picture_string);
    CASERET(DW_AT_mutable);
    CASERET(DW_AT_threads_scaled);
    CASERET(DW_AT_explicit);
    CASERET(DW_AT_object_pointer);
    CASERET(DW_AT_endianity);
    CASERET(DW_AT_elemental);
    CASERET(DW_AT_pure);
    CASERET(DW_AT_recursive);

    CASERET(DW_AT_MIPS_linkage_name);
    CASERET(DW_AT_sf_names);
    CASERET(DW_AT_src_info);
    CASERET(DW_AT_mac_info);
    CASERET(DW_AT_src_coords);
    CASERET(DW_AT_body_begin);
    CASERET(DW_AT_body_end);
    CASERET(DW_AT_GNU_vector);
    CASERET(DW_AT_VMS_rtnbeg_pd_address);
    CASERET(DW_AT_upc_threads_scaled);
    CASERET(DW_AT_lbase);
    CASERET(DW_AT_soffset);
    CASERET(DW_AT_lstride);
    CASERET(DW_AT_APPLE_optimized);
    CASERET(DW_AT_APPLE_flags);
    CASERET(DW_AT_APPLE_isa);
    CASERET(DW_AT_APPLE_block);
    CASERET(DW_AT_APPLE_major_runtime_vers);
    CASERET(DW_AT_APPLE_runtime_class);
    CASERET(DW_AT_APPLE_omit_frame_ptr);
    CASERET(DW_AT_APPLE_property_name);
    CASERET(DW_AT_APPLE_property_getter);
    CASERET(DW_AT_APPLE_property_setter);
    CASERET(DW_AT_APPLE_property_attribute);
    CASERET(DW_AT_APPLE_objc_complete_type);
    CASERET(DW_AT_APPLE_property);
  }

  if (value >= DW_AT_lo_user && value < DW_AT_hi_user)
    return "DW_AT_<user_defined>";

  return "DW_AT_<unknown>";
}

const char *
dwarf_form_name(unsigned value)
{
  switch (value) {
    CASERET(DW_FORM_addr);
    CASERET(DW_FORM_block2);
    CASERET(DW_FORM_block4);
    CASERET(DW_FORM_data2);
    CASERET(DW_FORM_data4);
    CASERET(DW_FORM_data8);
    CASERET(DW_FORM_string);
    CASERET(DW_FORM_block);
    CASERET(DW_FORM_block1);
    CASERET(DW_FORM_data1);
    CASERET(DW_FORM_flag);
    CASERET(DW_FORM_sdata);
    CASERET(DW_FORM_strp);
    CASERET(DW_FORM_udata);
    CASERET(DW_FORM_ref_addr);
    CASERET(DW_FORM_ref1);
    CASERET(DW_FORM_ref2);
    CASERET(DW_FORM_ref4);
    CASERET(DW_FORM_ref8);
    CASERET(DW_FORM_ref_udata);
    CASERET(DW_FORM_indirect);
    CASERET(DW_FORM_sec_offset);
    CASERET(DW_FORM_exprloc);
    CASERET(DW_FORM_flag_present);
    CASERET(DW_FORM_ref_sig8);
  }
  return "DW_FORM_<unknown>";
}

const char *
dwarf_stack_op_name(unsigned value)
{
  switch (value) {
    CASERET(DW_OP_addr);
    CASERET(DW_OP_deref);
    CASERET(DW_OP_const1u);
    CASERET(DW_OP_const1s);
    CASERET(DW_OP_const2u);
    CASERET(DW_OP_const2s);
    CASERET(DW_OP_const4u);
    CASERET(DW_OP_const4s);
    CASERET(DW_OP_const8u);
    CASERET(DW_OP_const8s);
    CASERET(DW_OP_constu);
    CASERET(DW_OP_consts);
    CASERET(DW_OP_dup);
    CASERET(DW_OP_drop);
    CASERET(DW_OP_over);
    CASERET(DW_OP_pick);
    CASERET(DW_OP_swap);
    CASERET(DW_OP_rot);
    CASERET(DW_OP_xderef);
    CASERET(DW_OP_abs);
    CASERET(DW_OP_and);
    CASERET(DW_OP_div);
    CASERET(DW_OP_minus);
    CASERET(DW_OP_mod);
    CASERET(DW_OP_mul);
    CASERET(DW_OP_neg);
    CASERET(DW_OP_not);
    CASERET(DW_OP_or);
    CASERET(DW_OP_plus);
    CASERET(DW_OP_plus_uconst);
    CASERET(DW_OP_shl);
    CASERET(DW_OP_shr);
    CASERET(DW_OP_shra);
    CASERET(DW_OP_xor);
    CASERET(DW_OP_bra);
    CASERET(DW_OP_eq);
    CASERET(DW_OP_ge);
    CASERET(DW_OP_gt);
    CASERET(DW_OP_le);
    CASERET(DW_OP_lt);
    CASERET(DW_OP_ne);
    CASERET(DW_OP_skip);
    CASERET(DW_OP_lit0);
    CASERET(DW_OP_lit1);
    CASERET(DW_OP_lit2);
    CASERET(DW_OP_lit3);
    CASERET(DW_OP_lit4);
    CASERET(DW_OP_lit5);
    CASERET(DW_OP_lit6);
    CASERET(DW_OP_lit7);
    CASERET(DW_OP_lit8);
    CASERET(DW_OP_lit9);
    CASERET(DW_OP_lit10);
    CASERET(DW_OP_lit11);
    CASERET(DW_OP_lit12);
    CASERET(DW_OP_lit13);
    CASERET(DW_OP_lit14);
    CASERET(DW_OP_lit15);
    CASERET(DW_OP_lit16);
    CASERET(DW_OP_lit17);
    CASERET(DW_OP_lit18);
    CASERET(DW_OP_lit19);
    CASERET(DW_OP_lit20);
    CASERET(DW_OP_lit21);
    CASERET(DW_OP_lit22);
    CASERET(DW_OP_lit23);
    CASERET(DW_OP_lit24);
    CASERET(DW_OP_lit25);
    CASERET(DW_OP_lit26);
    CASERET(DW_OP_lit27);
    CASERET(DW_OP_lit28);
    CASERET(DW_OP_lit29);
    CASERET(DW_OP_lit30);
    CASERET(DW_OP_lit31);
    CASERET(DW_OP_reg0);
    CASERET(DW_OP_reg1);
    CASERET(DW_OP_reg2);
    CASERET(DW_OP_reg3);
    CASERET(DW_OP_reg4);
    CASERET(DW_OP_reg5);
    CASERET(DW_OP_reg6);
    CASERET(DW_OP_reg7);
    CASERET(DW_OP_reg8);
    CASERET(DW_OP_reg9);
    CASERET(DW_OP_reg10);
    CASERET(DW_OP_reg11);
    CASERET(DW_OP_reg12);
    CASERET(DW_OP_reg13);
    CASERET(DW_OP_reg14);
    CASERET(DW_OP_reg15);
    CASERET(DW_OP_reg16);
    CASERET(DW_OP_reg17);
    CASERET(DW_OP_reg18);
    CASERET(DW_OP_reg19);
    CASERET(DW_OP_reg20);
    CASERET(DW_OP_reg21);
    CASERET(DW_OP_reg22);
    CASERET(DW_OP_reg23);
    CASERET(DW_OP_reg24);
    CASERET(DW_OP_reg25);
    CASERET(DW_OP_reg26);
    CASERET(DW_OP_reg27);
    CASERET(DW_OP_reg28);
    CASERET(DW_OP_reg29);
    CASERET(DW_OP_reg30);
    CASERET(DW_OP_reg31);
    CASERET(DW_OP_breg0);
    CASERET(DW_OP_breg1);
    CASERET(DW_OP_breg2);
    CASERET(DW_OP_breg3);
    CASERET(DW_OP_breg4);
    CASERET(DW_OP_breg5);
    CASERET(DW_OP_breg6);
    CASERET(DW_OP_breg7);
    CASERET(DW_OP_breg8);
    CASERET(DW_OP_breg9);
    CASERET(DW_OP_breg10);
    CASERET(DW_OP_breg11);
    CASERET(DW_OP_breg12);
    CASERET(DW_OP_breg13);
    CASERET(DW_OP_breg14);
    CASERET(DW_OP_breg15);
    CASERET(DW_OP_breg16);
    CASERET(DW_OP_breg17);
    CASERET(DW_OP_breg18);
    CASERET(DW_OP_breg19);
    CASERET(DW_OP_breg20);
    CASERET(DW_OP_breg21);
    CASERET(DW_OP_breg22);
    CASERET(DW_OP_breg23);
    CASERET(DW_OP_breg24);
    CASERET(DW_OP_breg25);
    CASERET(DW_OP_breg26);
    CASERET(DW_OP_breg27);
    CASERET(DW_OP_breg28);
    CASERET(DW_OP_breg29);
    CASERET(DW_OP_breg30);
    CASERET(DW_OP_breg31);
    CASERET(DW_OP_regx);
    CASERET(DW_OP_fbreg);
    CASERET(DW_OP_bregx);
    CASERET(DW_OP_piece);
    CASERET(DW_OP_deref_size);
    CASERET(DW_OP_xderef_size);
    CASERET(DW_OP_nop);
    CASERET(DW_OP_push_object_address);
    CASERET(DW_OP_call2);
    CASERET(DW_OP_call4);
    CASERET(DW_OP_call_ref);
    CASERET(DW_OP_form_tls_address);
    CASERET(DW_OP_call_frame_cfa);
    CASERET(DW_OP_bit_piece);
    CASERET(DW_OP_implicit_value);
    CASERET(DW_OP_stack_value);
    CASERET(DW_OP_GNU_push_tls_address);
    CASERET(DW_OP_GNU_uninit);
    CASERET(DW_OP_PGI_omp_thread_num);
  }
  return "DW_OP_<unknown>";
}

const char *
dwarf_virtuality_name(unsigned value)
{
  switch (value) {
    CASERET(DW_VIRTUALITY_none);
    CASERET(DW_VIRTUALITY_virtual);
    CASERET(DW_VIRTUALITY_pure_virtual);
  }
  return "DW_VIRTUALITY_<unknown>";
}

const char *
dwarf_lang_name(unsigned value)
{
  switch (value) {
    CASERET(DW_LANG_C89);
    CASERET(DW_LANG_C);
    CASERET(DW_LANG_Ada83);
    CASERET(DW_LANG_C_plus_plus);
    CASERET(DW_LANG_Cobol74);
    CASERET(DW_LANG_Cobol85);
    CASERET(DW_LANG_Fortran77);
    CASERET(DW_LANG_Fortran90);
    CASERET(DW_LANG_Pascal83);
    CASERET(DW_LANG_Modula2);
    CASERET(DW_LANG_Java);
    CASERET(DW_LANG_C99);
    CASERET(DW_LANG_Ada95);
    CASERET(DW_LANG_Fortran95);
    CASERET(DW_LANG_PLI);
    CASERET(DW_LANG_ObjC);
    CASERET(DW_LANG_ObjC_plus_plus);
    CASERET(DW_LANG_UPC);
    CASERET(DW_LANG_D);
    CASERET(DW_LANG_Mips_Assembler);
    CASERET(DW_LANG_Upc);
    // AOCC begin
    CASERET(DW_LANG_Fortran08);
    CASERET(DW_LANG_Fortran03);
    // AOCC end
  }
  return "DW_LANG_<unknown>";
}

const char *
dwarf_encoding_name(unsigned value)
{
  switch (value) {
    CASERET(DW_ATE_address);
    CASERET(DW_ATE_boolean);
    CASERET(DW_ATE_complex_float);
    CASERET(DW_ATE_float);
    CASERET(DW_ATE_signed);
    CASERET(DW_ATE_signed_char);
    CASERET(DW_ATE_unsigned);
    CASERET(DW_ATE_unsigned_char);
    CASERET(DW_ATE_imaginary_float);
    CASERET(DW_ATE_packed_decimal);
    CASERET(DW_ATE_numeric_string);
    CASERET(DW_ATE_edited);
    CASERET(DW_ATE_signed_fixed);
    CASERET(DW_ATE_unsigned_fixed);
    CASERET(DW_ATE_decimal_float);
  }
  return "DW_ATE_<unknown>";
}
