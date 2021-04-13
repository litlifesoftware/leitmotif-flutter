// Copyright 2021 LitLifeSoftware. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// A collection of Flutter widgets.
///
///
/// To use, import `package:lit_ui_lit/lit_ui_kit.dart`.
///
/// Dependencies used:
///
/// * package_info
/// * url_launcher
/// * intl
///
/// To use the above mentioned dependencies, please include them
/// separatly on the `pubspec.yaml` of your project. These will not be
/// exported to avoid any namespace issues.
library lit_ui_kit;

/// Files

/// Animated Buttons
export 'src/widgets/action_buttons/animated_action_button.dart';
export 'src/widgets/action_buttons/custom_action_button.dart';
export 'src/widgets/action_buttons/dummy_action_button.dart';
export 'src/widgets/action_buttons/animated_action_button.dart';
export 'src/widgets/action_buttons/collapse_on_scroll_action_button.dart';

/// App bars
export 'src/widgets/app_bars/custom_app_bar.dart';
export 'src/widgets/app_bars/lit_app_bar.dart';
export 'src/widgets/app_bars/lit_blurred_app_bar.dart';
export 'src/widgets/app_bars/fixed_on_scroll_appbar.dart';
export 'src/widgets/app_bars/minimalist_app_bar.dart';

/// Badges
export 'src/widgets/badges/lit_badge.dart';
export 'src/widgets/badges/lit_slider_badge.dart';

/// Bottom navigation
export 'src/widgets/bottom_navigation/lit_bottom_navigation.dart';

/// Buttons
export 'src/widgets/buttons/lit_tooltip_button.dart';
export 'src/widgets/buttons/lit_back_button.dart';
export 'src/widgets/buttons/circular_close_button.dart';
export 'src/widgets/buttons/lit_transform_animated_button.dart';
export 'src/widgets/buttons/lit_rounded_outlined_button.dart';
export 'src/widgets/buttons/lit_rounded_flat_button.dart';
export 'src/widgets/buttons/lit_rounded_elevated_button.dart';
export 'src/widgets/buttons/lit_toggle_button.dart';
export 'src/widgets/buttons/lit_switch_button.dart';
export 'src/widgets/buttons/lit_pushed_button.dart';
export 'src/widgets/buttons/lit_pushed_through_button.dart';
export 'src/widgets/buttons/lit_gradient_button.dart';
export 'src/widgets/buttons/dialog_back_button.dart';
export 'src/widgets/buttons/lit_bubble_button.dart';
export 'src/widgets/buttons/lit_glowing_button.dart';
export 'src/widgets/buttons/lit_plain_label_button.dart';

/// Collapsibles
export 'src/widgets/collapsible_card/collapsible_card_controller.dart';
export 'src/widgets/collapsible_card/collapsible_card.dart';
export 'src/widgets/collapsible_card/dummy_collapsible_card.dart';
export 'src/widgets/collapsible_card/titled_collapsible_card.dart';

/// Colors
export 'src/styles/lit_colors.dart';

/// Containers
export 'src/widgets/containers/fade_in_transform_container.dart';
export 'src/widgets/containers/fade_in_transform_scale_container.dart';
export 'src/widgets/containers/blured_background_container.dart';
export 'src/widgets/containers/scrollable_column.dart';
export 'src/widgets/containers/on_value_changed_animated_container.dart';
export 'src/widgets/containers/lit_constrained_size_box.dart';
export 'src/widgets/containers/lit_elevated_card.dart';
export 'src/widgets/containers/lit_gradient_card.dart';
export 'src/widgets/containers/lit_notification_container.dart';
export 'src/widgets/containers/lit_elevated_glass_card.dart';
export 'src/widgets/backgrounds/lit_animated_gradient_background.dart';
export 'src/widgets/containers/lit_slider_card.dart';
export 'src/widgets/containers/lit_draggable.dart';
export 'src/widgets/containers/lit_settings_footer.dart';
export 'src/widgets/containers/clean_ink_well.dart';

/// Controllers
export 'src/controller/lit_notification_controller.dart';
export 'src/controller/lit_route_controller.dart';
export 'src/controller/lit_focus_controller.dart';

/// Dialogs
export 'src/widgets/dialogs/website_info.dart';
export 'src/widgets/dialogs/about_app_dialog.dart';
export 'src/widgets/dialogs/lit_titled_dialog.dart';

/// Icon data
export 'src/icons/lit_icons.dart';

/// Loading indicators
export 'src/widgets/loading_indicators/juggling_loading_indicator.dart';
export 'src/widgets/page_views/indexed_page_view.dart';

/// Models
export 'src/model/lit_notification_data.dart';

/// Painted Icons
export 'src/widgets/painted_icons/lit_lock_icon.dart';

/// Scaffolds
export 'src/widgets/lit_scaffold/lit_scaffold.dart';

/// Screens
export 'src/screens/title_screen.dart';
export 'src/screens/age_confirmation_screen/age_confirmation_screen.dart';
export 'src/screens/application_licenses_screen/application_licenses_screen.dart';
export 'src/screens/lit_privacy_policy_screen.dart';
export 'src/screens/lit_onboarding_screen.dart';
export 'src/screens/lit_offline_app_disclaimer_screen.dart';
export 'src/screens/lit_credits_screen.dart';
export 'src/screens/lit_sign_up_screen.dart';
export 'src/screens/photosensitive_disclaimer_screen.dart';

/// Settings panels
export 'src/widgets/settings_panel/settings_tile.dart';
export 'src/widgets/settings_panel/settings_panel.dart';
export 'src/widgets/settings_panel/settings_panel_controller.dart';

/// Slider
export 'src/widgets/slider/lit_slider.dart';
export 'src/widgets/slider/lit_slider_overlay.dart';
export 'src/widgets/slider/lit_slider_thumb.dart';
export 'src/widgets/slider/lit_slider_toggle_button.dart';

/// Snackbars
export 'src/widgets/lit_snack_bar/lit_snackbar.dart';
export 'src/widgets/lit_snack_bar/lit_snackbar_controller.dart';
export 'src/widgets/lit_snack_bar/icon_snackbar.dart';
export 'src/widgets/lit_snack_bar/sliding_snackbar.dart';
export 'src/widgets/custom_info_bar/dummy_info_bar.dart';
export 'src/widgets/custom_info_bar/custom_info_bar.dart';
export 'src/widgets/custom_info_bar/transparent_info_bar.dart';

/// Text
export 'src/widgets/text/clipped_text.dart';
export 'src/widgets/text/scaled_down_text.dart';
export 'src/styles/lit_text_styles.dart';

/// Utility
export 'src/util/image_cache_controller.dart';
export 'src/util/hex_color_converter.dart';
export 'src/util/platform_info.dart';
export 'src/util/animation_on_scroll_controller.dart';
export 'src/util/calendar_controller.dart';
export 'src/util/calendar_localization_service.dart';
export 'src/util/lit_alternative_layout.dart';
export 'src/util/datetime_validation.dart';
export 'src/util/localized_date.dart';
