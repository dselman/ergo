(*
 * Copyright 2015-2016 IBM Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *)

Require Import String.
Require Import Qcert.Common.CommonTypes.
Require Import Qcert.Common.TypingRuntime.
Require Import ErgoSpec.Backend.Model.ErgoBackendModel.
Require Import ErgoSpec.Backend.Model.ErgoBackendRuntime.

Module EType(ergomodel:ErgoBackendModel).

  Definition empty_brand_model (x:unit) := TBrandModel.empty_brand_model.

  Definition record_kind : Set
    := RType.record_kind.

  Definition open_kind : record_kind
    := RType.Open.

  Definition closed_kind : record_kind
    := RType.Closed.

  Definition etype_struct {m:brand_relation} : Set
    := RType.rtype₀.
  Definition etype {m:brand_relation} : Set
    := RType.rtype.
  Definition t {m:brand_relation} : Set
    := etype.

  Definition sorted_pf_type {m:brand_relation} srl
      := SortingAdd.is_list_sorted Bindings.ODT_lt_dec (@Assoc.domain String.string etype srl) = true.

  Definition bottom {m:brand_relation} : etype
    := RType.Bottom.  
  Definition top {m:brand_relation} : etype
    := RType.Top.
  Definition empty {m:brand_relation} : etype
    := RType.Unit.
  Definition double {m:brand_relation} : etype
    := RType.Float.
  Definition integer {m:brand_relation} : etype
    := RType.Nat.
  Definition bool {m:brand_relation} : etype
    := RType.Bool.
  Definition string {m:brand_relation} : etype
    := RType.String.
  Definition array {m:brand_relation} : etype -> etype
    := RType.Coll.
  Definition record {m:brand_relation} : record_kind -> forall (r:list (String.string*etype)), sorted_pf_type r -> etype
    := RType.Rec.
  Definition sum {m:brand_relation} : etype -> etype -> etype
    := RType.Either.
  Definition arrow {m:brand_relation} : etype -> etype -> etype
    := RType.Arrow.
  Definition brand {m:brand_relation} : list String.string -> etype 
    := RType.Brand.

  Definition option {m:brand_relation} : etype -> etype
    := RType.Option.
  
  (* Additional support for brand models extraction -- will have to be tested/consolidated *)

  Definition brand_context_type {m:brand_relation} : Set := (String.string*etype).
  
  Definition brand_relation : Set := brand_relation.
  Definition make_brand_relation := Schema.mk_brand_relation.
  Definition brand_model : Set := brand_model.
  Definition make_brand_model := Schema.make_brand_model_from_decls_fails.
  Definition typing_runtime : Set := typing_runtime.

End EType.

