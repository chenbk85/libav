FATE_FILTER-$(call FILTERDEMDEC, DELOGO, RM, RV30) += fate-filter-delogo
fate-filter-delogo: CMD = framecrc -i $(SAMPLES)/real/rv30.rm -vf delogo=show=0:x=290:y=25:w=26:h=16 -an

FATE_YADIF += fate-filter-yadif-mode0
fate-filter-yadif-mode0: CMD = framecrc -flags bitexact -idct simple -i $(SAMPLES)/mpeg2/mpeg2_field_encoding.ts -vf yadif=0

FATE_YADIF += fate-filter-yadif-mode1
fate-filter-yadif-mode1: CMD = framecrc -flags bitexact -idct simple -i $(SAMPLES)/mpeg2/mpeg2_field_encoding.ts -vf yadif=1

FATE_FILTER-$(call FILTERDEMDEC, YADIF, MPEGTS, MPEG2VIDEO) += $(FATE_YADIF)

FATE_SAMPLES_AVCONV += $(FATE_FILTER-yes)


FATE_FILTER_VSYNTH-$(CONFIG_BOXBLUR_FILTER) += fate-filter-boxblur
fate-filter-boxblur: CMD = framecrc -c:v pgmyuv -i $(SRC) -vf boxblur=2:1

FATE_FILTER_VSYNTH-$(CONFIG_DRAWBOX_FILTER) += fate-filter-drawbox
fate-filter-drawbox: CMD = framecrc -c:v pgmyuv -i $(SRC) -vf drawbox=10:20:200:60:red@0.5

FATE_FILTER_VSYNTH-$(CONFIG_FADE_FILTER) += fate-filter-fade
fate-filter-fade: CMD = framecrc -c:v pgmyuv -i $(SRC) -vf fade=in:0:25,fade=out:25:25

FATE_FILTER_VSYNTH-$(CONFIG_GRADFUN_FILTER) += fate-filter-gradfun
fate-filter-gradfun: CMD = framecrc -c:v pgmyuv -i $(SRC) -vf gradfun

FATE_FILTER_VSYNTH-$(CONFIG_HQDN3D_FILTER) += fate-filter-hqdn3d
fate-filter-hqdn3d: CMD = framecrc -c:v pgmyuv -i $(SRC) -vf hqdn3d

FATE_FILTER_VSYNTH-$(CONFIG_INTERLACE_FILTER) += fate-filter-interlace
fate-filter-interlace: CMD = framecrc -c:v pgmyuv -i $(SRC) -vf interlace

FATE_FILTER_VSYNTH-$(CONFIG_NEGATE_FILTER) += fate-filter-negate
fate-filter-negate: CMD = framecrc -c:v pgmyuv -i $(SRC) -vf negate

FATE_FILTER_VSYNTH-$(CONFIG_OVERLAY_FILTER) += fate-filter-overlay
fate-filter-overlay: CMD = framecrc -c:v pgmyuv -i $(SRC) -c:v pgmyuv -i $(SRC) -filter_complex_script $(SRC_PATH)/tests/filtergraphs/overlay

FATE_FILTER_VSYNTH-$(call ALLYES, SETPTS_FILTER  SETTB_FILTER) += fate-filter-setpts
fate-filter-setpts: CMD = framecrc -c:v pgmyuv -i $(SRC) -filter_script $(SRC_PATH)/tests/filtergraphs/setpts

FATE_FILTER_VSYNTH-$(CONFIG_TRANSPOSE_FILTER) += fate-filter-transpose
fate-filter-transpose: CMD = framecrc -c:v pgmyuv -i $(SRC) -vf transpose

FATE_FILTER_VSYNTH-$(CONFIG_UNSHARP_FILTER) += fate-filter-unsharp
fate-filter-unsharp: CMD = framecrc -c:v pgmyuv -i $(SRC) -vf unsharp


$(FATE_FILTER_VSYNTH-yes): $(VREF)
$(FATE_FILTER_VSYNTH-yes): SRC = $(TARGET_PATH)/tests/vsynth1/%02d.pgm

FATE_AVCONV-$(call DEMDEC, IMAGE2, PGMYUV) += $(FATE_FILTER_VSYNTH-yes)

fate-vfilter: $(FATE_FILTER-yes) $(FATE_FILTER_VSYNTH-yes)

fate-filter: fate-afilter fate-vfilter
