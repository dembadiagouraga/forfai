# Voice Note Feature Implementation Plan

## Overview
This plan outlines the step-by-step implementation of voice note functionality for product listings. The feature will allow sellers to record and attach voice descriptions (up to 2 minutes) to their product listings.

## Key Requirements
- Maximum voice note duration: 2 minutes
- Voice notes should be playable on both customer and admin sides
- Implementation should not affect existing app functionality
- Use existing voice chat mechanism for recording and playback
- Maintain UI consistency with the existing app

## Implementation Phases

### Phase 1: Backend Changes
- Create database migration to add voice note fields
- Update product model and repository
- Add voice note upload handling in ProductService
- Update API resources to include voice note data

### Phase 2: Customer App Changes
- Update product data model
- Add translation keys
- Update create/edit product state and events
- Create voice note recording UI components
- Implement voice note playback in product details

### Phase 3: Admin Side Changes
- Update admin product detail view to show voice notes
- Add voice note playback in admin interface

### Phase 4: Testing
- Test voice note recording
- Test voice note playback
- Test voice note editing and deletion
- Verify existing functionality is not affected

## Files to Modify

### Backend
- Migration file
- ProductService.php
- ProductResource.php

### Customer App
- product_model.dart
- tr_keys.dart
- create_product_state.dart
- create_product_event.dart
- create_product_bloc.dart
- edit_product_state.dart
- edit_product_event.dart
- edit_product_bloc.dart
- New files for UI components

### Admin
- product-details.js
- VoiceMessageBubble component

Follow the step-by-step instructions in each file to implement the feature correctly.
