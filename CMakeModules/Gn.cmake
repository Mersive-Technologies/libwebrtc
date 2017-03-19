set(_GEN_ARGS "use_gold=false target_cpu=\\\"${TARGET_CPU}\\\" target_os=\\\"${TARGET_OS}\\\"")

if (MSVC OR XCODE)
  set(_GEN_ARGS ${_GEN_ARGS} is_debug=$<$<CONFIG:Debug>:true>$<$<CONFIG:Release>:false>$<$<CONFIG:RelWithDebInfo>:false>$<$<CONFIG:MinSizeRel>:false>)
  set(_NINJA_BUILD_DIR out/$<$<CONFIG:Debug>:Debug>$<$<CONFIG:Release>:Release>$<$<CONFIG:RelWithDebInfo>:Release>$<$<CONFIG:MinSizeRel>:Release>)
elseif (CMAKE_BUILD_TYPE MATCHES Debug)
  set(_GEN_ARGS "${_GEN_ARGS} is_debug=true")
  set(_NINJA_BUILD_DIR out/Debug)
else (MSVC OR XCODE)
  set(_GEN_ARGS "${_GEN_ARGS} is_debug=false")
  set(_NINJA_BUILD_DIR out/Release)
endif (MSVC OR XCODE)

if (BUILD_TESTS)
  set(_GEN_ARGS "${_GEN_ARGS} rtc_include_tests=true")
else (BUILD_TESTS)
  set(_GEN_ARGS "${_GEN_ARGS} rtc_include_tests=false")
endif (BUILD_TESTS)

if (GN_EXTRA_ARGS)
  set(_GEN_ARGS "${_GEN_ARGS} ${GN_EXTRA_ARGS}")
endif (GN_EXTRA_ARGS)

set(_GEN_COMMAND gn gen ${_NINJA_BUILD_DIR} --args=\"${_GEN_ARGS}\")
