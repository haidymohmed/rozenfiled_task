//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <local_auth_windows/local_auth_plugin.h>
#include <modal_progress_hud_nsn/modal_progress_hud_nsn_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  LocalAuthPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("LocalAuthPlugin"));
  ModalProgressHudNsnPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ModalProgressHudNsnPlugin"));
}
