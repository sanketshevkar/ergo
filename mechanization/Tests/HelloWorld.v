(*
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
Require Import List.
Require Import ErgoSpec.Common.Utils.ENames.
Require Import ErgoSpec.Common.Utils.EResult.
Require Import ErgoSpec.Common.Types.ErgoType.
Require Import ErgoSpec.Ergo.Lang.Ergo.
Require Import ErgoSpec.Compiler.ErgoCompiler.

Section HelloWorld.
  Open Scope string_scope.
  
  (*
package org.accordproject.helloworld

contract HelloWorld over TemplateModel {
   // Simple Clause
   clause helloworld(request Request) Response {
     return new Response{ output: "Hello " ++ contract.name ++ " (" ++ request.input ++ ")" }
  }
}
*)

  Definition cl1 : ergo_clause :=
    mkClause "helloworld"
             dummy_location
             (mkLambda
                (("request", mk_type dummy_location (ErgoTypeClassRef (AbsoluteRef "Request")))::nil)
                (mk_type dummy_location (ErgoTypeClassRef (AbsoluteRef "Response")))
                None
                None
                (mk_stmt dummy_location (SReturn (mk_expr dummy_location (EVar "request"))))).

  Definition c1 : ergo_contract :=
    mkContract "HelloWorld"
               dummy_location
               (mk_type dummy_location (ErgoTypeClassRef (AbsoluteRef "TemplateModel")))
               None
               (cl1::nil).
  
  Definition p1 : ergo_module :=
    mkModule "org.accordproject.helloworld"
             dummy_location
             nil
             (mk_decl dummy_location (DContract c1)::nil).

  (* Eval vm_compute in (ErgoCompiler.ergo_module_to_javascript nil p1). *)
End HelloWorld.

