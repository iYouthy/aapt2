set(AAPT2_PROTO_SRC)
set(AAPT2_PROTO_HDRS)
set(AAPT2_PROTO_DIR ${SRC}/base/tools/aapt2)

file(GLOB_RECURSE PROTO_FILES ${AAPT2_PROTO_DIR}/*.proto)

foreach (proto ${PROTO_FILES})
    get_filename_component(FIL_WE ${proto} NAME_WE)

    if (DEFINED PROTOC_PATH)
        execute_process(
                COMMAND ${PROTOC_COMPILER} ${proto}
                --proto_path=${AAPT2_PROTO_DIR}
                --cpp_out=${AAPT2_PROTO_DIR}
                COMMAND_ECHO STDOUT
                RESULT_VARIABLE RESULT
                WORKING_DIRECTORY ${AAPT2_PROTO_DIR})

        if (RESULT EQUAL 0)
            message(STATUS "generate cpp file ${TARGET_CPP_FILE}")
            message(STATUS "generate head file ${TARGET_HEAD_FILE}")
        endif ()
    endif ()

    set(TARGET_CPP_FILE "${AAPT2_PROTO_DIR}/${FIL_WE}.pb.cc")
    set(TARGET_HEAD_FILE "${AAPT2_PROTO_DIR}/${FIL_WE}.pb.h")

    if (EXISTS ${TARGET_CPP_FILE} AND EXISTS ${TARGET_HEAD_FILE})
        list(APPEND AAPT2_PROTO_SRC ${TARGET_CPP_FILE})
        list(APPEND AAPT2_PROTO_HDRS ${TARGET_HEAD_FILE})
    endif ()
endforeach ()

if (DEFINED PROTOC_PATH)
    set_source_files_properties(${AAPT2_PROTO_SRC} PROPERTIES GENERATED TRUE)
    set_source_files_properties(${AAPT2_PROTO_HDRS} PROPERTIES GENERATED TRUE)
endif ()

add_library(aapt2 SHARED
        ${SRC}/base/tools/aapt2/Main.cpp
        ${SRC}/base/tools/aapt2/cmd/Command.cpp
        ${SRC}/base/tools/aapt2/cmd/Compile.cpp
        ${SRC}/base/tools/aapt2/cmd/Convert.cpp
        ${SRC}/base/tools/aapt2/cmd/Diff.cpp
        ${SRC}/base/tools/aapt2/cmd/Dump.cpp
        ${SRC}/base/tools/aapt2/cmd/Link.cpp
        ${SRC}/base/tools/aapt2/cmd/Optimize.cpp
        ${SRC}/base/tools/aapt2/cmd/Util.cpp
        ${SRC}/base/tools/aapt2/compile/IdAssigner.cpp
        ${SRC}/base/tools/aapt2/compile/InlineXmlFormatParser.cpp
        ${SRC}/base/tools/aapt2/compile/NinePatch.cpp
        ${SRC}/base/tools/aapt2/compile/Png.cpp
        ${SRC}/base/tools/aapt2/compile/PngChunkFilter.cpp
        ${SRC}/base/tools/aapt2/compile/PngCrunch.cpp
        ${SRC}/base/tools/aapt2/compile/Pseudoloca
        ${SRC}/base/tools/aapt2/compile/Pseudolocalizer.cpp
        ${SRC}/base/tools/aapt2/compile/XmlIdCollector.cpp
        ${SRC}/base/tools/aapt2/configuration/ConfigurationParser.cpp
        ${SRC}/base/tools/aapt2/dump/DumpManifest.cpp
        ${SRC}/base/tools/aapt2/filter/AbiFilter.cpp
        ${SRC}/base/tools/aapt2/filter/ConfigFilter.cpp
        ${SRC}/base/tools/aapt2/format/Archive.cpp
        ${SRC}/base/tools/aapt2/format/Container.cpp
        ${SRC}/base/tools/aapt2/format/binary/BinaryResourceParser.cpp
        ${SRC}/base/tools/aapt2/format/binary/ResChunkPullParser.cpp
        ${SRC}/base/tools/aapt2/format/binary/TableFlattener.cpp
        ${SRC}/base/tools/aapt2/format/binary/XmlFlattener.cpp
        ${SRC}/base/tools/aapt2/format/proto/ProtoDeserialize.cpp
        ${SRC}/base/tools/aapt2/format/proto/ProtoSerialize.cpp
        ${SRC}/base/tools/aapt2/io/BigBufferStream.cpp
        ${SRC}/base/tools/aapt2/io/File.cpp
        ${SRC}/base/tools/aapt2/io/FileStream.cpp
        ${SRC}/base/tools/aapt2/io/FileSystem.cpp
        ${SRC}/base/tools/aapt2/io/StringStream.cpp
        ${SRC}/base/tools/aapt2/io/Util.cpp
        ${SRC}/base/tools/aapt2/io/ZipArchive.cpp
        ${SRC}/base/tools/aapt2/link/AutoVersioner.cpp
        ${SRC}/base/tools/aapt2/link/ManifestFixer.cpp
        ${SRC}/base/tools/aapt2/link/NoDefaultResourceRemover.cpp
        ${SRC}/base/tools/aapt2/link/ProductFilter.cpp
        ${SRC}/base/tools/aapt2/link/PrivateAttributeMover.cpp
        ${SRC}/base/tools/aapt2/link/ReferenceLinker.cpp
        ${SRC}/base/tools/aapt2/link/ResourceExcluder.cpp
        ${SRC}/base/tools/aapt2/link/TableMerger.cpp
        ${SRC}/base/tools/aapt2/link/XmlCompatVersioner.cpp
        ${SRC}/base/tools/aapt2/link/XmlNamespaceRemover.cpp
        ${SRC}/base/tools/aapt2/link/XmlReferenceLinker.cpp
        ${SRC}/base/tools/aapt2/optimize/MultiApkGenerator.cpp
        ${SRC}/base/tools/aapt2/optimize/ResourceDeduper.cpp
        ${SRC}/base/tools/aapt2/optimize/ResourceFilter.cpp
        ${SRC}/base/tools/aapt2/optimize/ResourcePathShortener.cpp
        ${SRC}/base/tools/aapt2/optimize/VersionCollapser.cpp
        ${SRC}/base/tools/aapt2/process/SymbolTable.cpp
        ${SRC}/base/tools/aapt2/split/TableSplitter.cpp
        ${SRC}/base/tools/aapt2/text/Printer.cpp
        ${SRC}/base/tools/aapt2/text/Unicode.cpp
        ${SRC}/base/tools/aapt2/text/Utf8Iterator.cpp
        ${SRC}/base/tools/aapt2/util/BigBuffer.cpp
        ${SRC}/base/tools/aapt2/util/Files.cpp
        ${SRC}/base/tools/aapt2/util/Util.cpp
        ${SRC}/base/tools/aapt2/Debug.cpp
        ${SRC}/base/tools/aapt2/DominatorTree.cpp
        ${SRC}/base/tools/aapt2/java/AnnotationProcessor.cpp
        ${SRC}/base/tools/aapt2/java/ClassDefinition.cpp
        ${SRC}/base/tools/aapt2/java/JavaClassGenerator.cpp
        ${SRC}/base/tools/aapt2/java/ManifestClassGenerator.cpp
        ${SRC}/base/tools/aapt2/java/ProguardRules.cpp
        ${SRC}/base/tools/aapt2/LoadedApk.cpp
        ${SRC}/base/tools/aapt2/Resource.cpp
        ${SRC}/base/tools/aapt2/ResourceParser.cpp
        ${SRC}/base/tools/aapt2/ResourceTable.cpp
        ${SRC}/base/tools/aapt2/ResourceUtils.cpp
        ${SRC}/base/tools/aapt2/ResourceValues.cpp
        ${SRC}/base/tools/aapt2/SdkConstants.cpp
        ${SRC}/base/tools/aapt2/StringPool.cpp
        ${SRC}/base/tools/aapt2/trace/TraceBuffer.cpp
        ${SRC}/base/tools/aapt2/xml/XmlActionExecutor.cpp
        ${SRC}/base/tools/aapt2/xml/XmlDom.cpp
        ${SRC}/base/tools/aapt2/xml/XmlPullParser.cpp
        ${SRC}/base/tools/aapt2/xml/XmlUtil.cpp
        ${SRC}/base/tools/aapt2/ValueTransformer.cpp
        ${AAPT2_PROTO_SRC} ${AAPT2_PROTO_HDRS})

target_include_directories(aapt2
        PUBLIC
        ${SRC}/base/tools/aapt2
        PRIVATE
        ${SRC}/libbase/include
        ${SRC}/core/include
        ${SRC}/logging/liblog/include
        ${SRC}/base/libs/androidfw/include
        ${SRC}/libziparchive/include
        ${SRC}/incremental_delivery/incfs/util/include
        ${SRC}/base/cmds/idmap2/libidmap2_policies/include
        ${SRC}/third_party/protobuf/src
        ${SRC}/third_party/expat/lib
        ${SRC}/third_party/fmtlib/include
        ${SRC}/third_party/libpng)

target_compile_options(aapt2 PRIVATE
        -Wno-unused-parameter
        -Wno-missing-field-initializers
        -fno-exceptions
        -fno-rtti)

target_link_libraries(aapt2
        libbase libutils libcutils liblog libandroidfw libziparchive
        libincfs libprotobuf libpng libexpat libz)

# Support 16 KB page sizes
# https://developer.android.com/guide/practices/page-sizes?hl=zh-cn#cmake
target_link_options(${CMAKE_PROJECT_NAME} PRIVATE "-Wl,-z,max-page-size=16384")