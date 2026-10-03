/*******************************************************************************************************************
Copyright (c) 2023 Cycling '74

The code that Max generates automatically and that end users are capable of
exporting and using, and any associated documentation files (the “Software”)
is a work of authorship for which Cycling '74 is the author and owner for
copyright purposes.

This Software is dual-licensed either under the terms of the Cycling '74
License for Max-Generated Code for Export, or alternatively under the terms
of the General Public License (GPL) Version 3. You may use the Software
according to either of these licenses as it is most appropriate for your
project on a case-by-case basis (proprietary or not).

A) Cycling '74 License for Max-Generated Code for Export

A license is hereby granted, free of charge, to any person obtaining a copy
of the Software (“Licensee”) to use, copy, modify, merge, publish, and
distribute copies of the Software, and to permit persons to whom the Software
is furnished to do so, subject to the following conditions:

The Software is licensed to Licensee for all uses that do not include the sale,
sublicensing, or commercial distribution of software that incorporates this
source code. This means that the Licensee is free to use this software for
educational, research, and prototyping purposes, to create musical or other
creative works with software that incorporates this source code, or any other
use that does not constitute selling software that makes use of this source
code. Commercial distribution also includes the packaging of free software with
other paid software, hardware, or software-provided commercial services.

For entities with UNDER $200k in annual revenue or funding, a license is hereby
granted, free of charge, for the sale, sublicensing, or commercial distribution
of software that incorporates this source code, for as long as the entity's
annual revenue remains below $200k annual revenue or funding.

For entities with OVER $200k in annual revenue or funding interested in the
sale, sublicensing, or commercial distribution of software that incorporates
this source code, please send inquiries to licensing@cycling74.com.

The above copyright notice and this license shall be included in all copies or
substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

Please see
https://support.cycling74.com/hc/en-us/articles/10730637742483-RNBO-Export-Licensing-FAQ
for additional information

B) General Public License Version 3 (GPLv3)
Details of the GPLv3 license can be found at: https://www.gnu.org/licenses/gpl-3.0.html
*******************************************************************************************************************/

#ifdef RNBO_LIB_PREFIX
#define STR_IMPL(A) #A
#define STR(A) STR_IMPL(A)
#define RNBO_LIB_INCLUDE(X) STR(RNBO_LIB_PREFIX/X)
#else
#define RNBO_LIB_INCLUDE(X) #X
#endif // RNBO_LIB_PREFIX
#ifdef RNBO_INJECTPLATFORM
#define RNBO_USECUSTOMPLATFORM
#include RNBO_INJECTPLATFORM
#endif // RNBO_INJECTPLATFORM

#include RNBO_LIB_INCLUDE(RNBO_Common.h)
#include RNBO_LIB_INCLUDE(RNBO_AudioSignal.h)

namespace RNBO {


#define trunc(x) ((Int)(x))
#define autoref auto&

#if defined(__GNUC__) || defined(__clang__)
    #define RNBO_RESTRICT __restrict__
#elif defined(_MSC_VER)
    #define RNBO_RESTRICT __restrict
#endif

#define FIXEDSIZEARRAYINIT(...) { }

template <class ENGINE = INTERNALENGINE> class rnbomatic : public PatcherInterfaceImpl {

friend class EngineCore;
friend class Engine;
friend class MinimalEngine<>;
public:

rnbomatic()
: _internalEngine(this)
{
}

~rnbomatic()
{
    deallocateSignals();
}

Index getNumMidiInputPorts() const {
    return 0;
}

void processMidiEvent(MillisecondTime , int , ConstByteArray , Index ) {}

Index getNumMidiOutputPorts() const {
    return 0;
}

void process(
    const SampleValue * const* inputs,
    Index numInputs,
    SampleValue * const* outputs,
    Index numOutputs,
    Index n
) {
    RNBO_UNUSED(numInputs);
    RNBO_UNUSED(inputs);
    this->vs = n;
    this->updateTime(this->getEngine()->getCurrentTime(), (ENGINE*)nullptr, true);
    SampleValue * out1 = (numOutputs >= 1 && outputs[0] ? outputs[0] : this->dummyBuffer);
    SampleValue * out2 = (numOutputs >= 2 && outputs[1] ? outputs[1] : this->dummyBuffer);
    SampleValue * out3 = (numOutputs >= 3 && outputs[2] ? outputs[2] : this->dummyBuffer);
    SampleValue * out4 = (numOutputs >= 4 && outputs[3] ? outputs[3] : this->dummyBuffer);
    SampleValue * out5 = (numOutputs >= 5 && outputs[4] ? outputs[4] : this->dummyBuffer);
    SampleValue * out6 = (numOutputs >= 6 && outputs[5] ? outputs[5] : this->dummyBuffer);
    SampleValue * out7 = (numOutputs >= 7 && outputs[6] ? outputs[6] : this->dummyBuffer);
    SampleValue * out8 = (numOutputs >= 8 && outputs[7] ? outputs[7] : this->dummyBuffer);
    this->p_01_perform(out1, this->dummyBuffer, n);
    this->p_02_perform(out2, this->dummyBuffer, n);
    this->p_03_perform(out3, this->dummyBuffer, n);
    this->p_04_perform(out4, this->dummyBuffer, n);
    this->p_05_perform(out5, this->dummyBuffer, n);
    this->p_06_perform(out6, this->dummyBuffer, n);
    this->p_07_perform(out7, this->dummyBuffer, n);
    this->p_08_perform(out8, this->dummyBuffer, n);
    this->stackprotect_perform(n);
    this->globaltransport_advance();
    this->advanceTime((ENGINE*)nullptr);
    this->audioProcessSampleCount += this->vs;
}

void prepareToProcess(number sampleRate, Index maxBlockSize, bool force) {
    RNBO_ASSERT(this->_isInitialized);

    if (this->maxvs < maxBlockSize || !this->didAllocateSignals) {
        this->globaltransport_tempo = resizeSignal(this->globaltransport_tempo, this->maxvs, maxBlockSize);
        this->globaltransport_state = resizeSignal(this->globaltransport_state, this->maxvs, maxBlockSize);
        this->zeroBuffer = resizeSignal(this->zeroBuffer, this->maxvs, maxBlockSize);
        this->dummyBuffer = resizeSignal(this->dummyBuffer, this->maxvs, maxBlockSize);
        this->didAllocateSignals = true;
    }

    const bool sampleRateChanged = sampleRate != this->sr;
    const bool maxvsChanged = maxBlockSize != this->maxvs;
    const bool forceDSPSetup = sampleRateChanged || maxvsChanged || force;

    if (sampleRateChanged || maxvsChanged) {
        this->vs = maxBlockSize;
        this->maxvs = maxBlockSize;
        this->sr = sampleRate;
        this->invsr = 1 / sampleRate;
    }

    this->globaltransport_dspsetup(forceDSPSetup);
    this->p_01->prepareToProcess(sampleRate, maxBlockSize, force);
    this->p_02->prepareToProcess(sampleRate, maxBlockSize, force);
    this->p_03->prepareToProcess(sampleRate, maxBlockSize, force);
    this->p_04->prepareToProcess(sampleRate, maxBlockSize, force);
    this->p_05->prepareToProcess(sampleRate, maxBlockSize, force);
    this->p_06->prepareToProcess(sampleRate, maxBlockSize, force);
    this->p_07->prepareToProcess(sampleRate, maxBlockSize, force);
    this->p_08->prepareToProcess(sampleRate, maxBlockSize, force);

    if (sampleRateChanged)
        this->onSampleRateChanged(sampleRate);
}

number msToSamps(MillisecondTime ms, number sampleRate) {
    return ms * sampleRate * 0.001;
}

MillisecondTime sampsToMs(SampleIndex samps) {
    return samps * (this->invsr * 1000);
}

Index getNumInputChannels() const {
    return 0;
}

Index getNumOutputChannels() const {
    return 8;
}

DataRef* getDataRef(DataRefIndex index)  {
    switch (index) {
    default:
        {
        return nullptr;
        }
    }
}

DataRefIndex getNumDataRefs() const {
    return 0;
}

void processDataViewUpdate(DataRefIndex index, MillisecondTime time) {
    this->p_01->processDataViewUpdate(index, time);
    this->p_02->processDataViewUpdate(index, time);
    this->p_03->processDataViewUpdate(index, time);
    this->p_04->processDataViewUpdate(index, time);
    this->p_05->processDataViewUpdate(index, time);
    this->p_06->processDataViewUpdate(index, time);
    this->p_07->processDataViewUpdate(index, time);
    this->p_08->processDataViewUpdate(index, time);
}

void initialize() {
    RNBO_ASSERT(!this->_isInitialized);
    this->assign_defaults();
    this->applyState();
    this->initializeObjects();
    this->allocateDataRefs();
    this->startup();
    this->_isInitialized = true;
}

void getPreset(PatcherStateInterface& preset) {
    this->updateTime(this->getEngine()->getCurrentTime(), (ENGINE*)nullptr);
    preset["__presetid"] = "rnbo";
    this->param_01_getPresetValue(getSubState(preset, "kick_baseHz"));
    this->param_02_getPresetValue(getSubState(preset, "kick_pitchAmount"));
    this->param_03_getPresetValue(getSubState(preset, "kick_pitchDecayMs"));
    this->param_04_getPresetValue(getSubState(preset, "kick_ampDecayMs"));
    this->param_05_getPresetValue(getSubState(preset, "kick_fmIndex"));
    this->param_06_getPresetValue(getSubState(preset, "kick_fmRatio"));
    this->param_07_getPresetValue(getSubState(preset, "kick_resonMix"));
    this->param_08_getPresetValue(getSubState(preset, "kick_resonHz"));
    this->param_09_getPresetValue(getSubState(preset, "kick_resonQ"));
    this->param_10_getPresetValue(getSubState(preset, "kick_clickLevel"));
    this->param_11_getPresetValue(getSubState(preset, "kick_drive"));
    this->param_12_getPresetValue(getSubState(preset, "kick_level"));
    this->param_13_getPresetValue(getSubState(preset, "snare_bodyHz"));
    this->param_14_getPresetValue(getSubState(preset, "snare_bodyBend"));
    this->param_15_getPresetValue(getSubState(preset, "snare_noiseDecayMs"));
    this->param_16_getPresetValue(getSubState(preset, "snare_bodyDecayMs"));
    this->param_17_getPresetValue(getSubState(preset, "snare_bodyFM"));
    this->param_18_getPresetValue(getSubState(preset, "snare_noiseHz"));
    this->param_19_getPresetValue(getSubState(preset, "snare_bodyLevel"));
    this->param_20_getPresetValue(getSubState(preset, "snare_noiseLevel"));
    this->param_21_getPresetValue(getSubState(preset, "snare_noiseQ"));
    this->param_22_getPresetValue(getSubState(preset, "snare_snap"));
    this->param_23_getPresetValue(getSubState(preset, "snare_drive"));
    this->param_24_getPresetValue(getSubState(preset, "snare_level"));
    this->param_25_getPresetValue(getSubState(preset, "hat_metalHz"));
    this->param_26_getPresetValue(getSubState(preset, "hat_inharmonicity"));
    this->param_27_getPresetValue(getSubState(preset, "hat_noiseDecayMs"));
    this->param_28_getPresetValue(getSubState(preset, "hat_decayMs"));
    this->param_29_getPresetValue(getSubState(preset, "hat_spread"));
    this->param_30_getPresetValue(getSubState(preset, "hat_filterHz"));
    this->param_31_getPresetValue(getSubState(preset, "hat_metalLevel"));
    this->param_32_getPresetValue(getSubState(preset, "hat_noiseLevel"));
    this->param_33_getPresetValue(getSubState(preset, "hat_filterQ"));
    this->param_34_getPresetValue(getSubState(preset, "hat_attack"));
    this->param_35_getPresetValue(getSubState(preset, "hat_drive"));
    this->param_36_getPresetValue(getSubState(preset, "hat_level"));
    this->param_37_getPresetValue(getSubState(preset, "clap_count"));
    this->param_38_getPresetValue(getSubState(preset, "clap_scatter"));
    this->param_39_getPresetValue(getSubState(preset, "clap_tailDecayMs"));
    this->param_40_getPresetValue(getSubState(preset, "clap_burstDecayMs"));
    this->param_41_getPresetValue(getSubState(preset, "clap_spacingMs"));
    this->param_42_getPresetValue(getSubState(preset, "clap_filterHz"));
    this->param_43_getPresetValue(getSubState(preset, "clap_balance"));
    this->param_44_getPresetValue(getSubState(preset, "clap_tailLevel"));
    this->param_45_getPresetValue(getSubState(preset, "clap_filterQ"));
    this->param_46_getPresetValue(getSubState(preset, "clap_brightness"));
    this->param_47_getPresetValue(getSubState(preset, "clap_drive"));
    this->param_48_getPresetValue(getSubState(preset, "clap_level"));
    this->param_49_getPresetValue(getSubState(preset, "tom_pitchHz"));
    this->param_50_getPresetValue(getSubState(preset, "tom_bendDecayMs"));
    this->param_51_getPresetValue(getSubState(preset, "tom_fmAmount"));
    this->param_52_getPresetValue(getSubState(preset, "tom_decayMs"));
    this->param_53_getPresetValue(getSubState(preset, "tom_bendHz"));
    this->param_54_getPresetValue(getSubState(preset, "tom_fmRatio"));
    this->param_55_getPresetValue(getSubState(preset, "tom_noiseLevel"));
    this->param_56_getPresetValue(getSubState(preset, "tom_noiseDecayMs"));
    this->param_57_getPresetValue(getSubState(preset, "tom_drive"));
    this->param_58_getPresetValue(getSubState(preset, "tom_modeRatio"));
    this->param_59_getPresetValue(getSubState(preset, "tom_modeLevel"));
    this->param_60_getPresetValue(getSubState(preset, "tom_level"));
    this->param_61_getPresetValue(getSubState(preset, "rim_pitchHz"));
    this->param_62_getPresetValue(getSubState(preset, "rim_modeLevel"));
    this->param_63_getPresetValue(getSubState(preset, "rim_clickLevel"));
    this->param_64_getPresetValue(getSubState(preset, "rim_decayMs"));
    this->param_65_getPresetValue(getSubState(preset, "rim_modeRatio"));
    this->param_66_getPresetValue(getSubState(preset, "rim_noiseDecayMs"));
    this->param_67_getPresetValue(getSubState(preset, "rim_fmAmount"));
    this->param_68_getPresetValue(getSubState(preset, "rim_fmRatio"));
    this->param_69_getPresetValue(getSubState(preset, "rim_drive"));
    this->param_70_getPresetValue(getSubState(preset, "rim_filterHz"));
    this->param_71_getPresetValue(getSubState(preset, "rim_filterQ"));
    this->param_72_getPresetValue(getSubState(preset, "rim_level"));
    this->param_73_getPresetValue(getSubState(preset, "bell_pitchHz"));
    this->param_74_getPresetValue(getSubState(preset, "bell_fmIndex"));
    this->param_75_getPresetValue(getSubState(preset, "bell_fmDecayMs"));
    this->param_76_getPresetValue(getSubState(preset, "bell_decayMs"));
    this->param_77_getPresetValue(getSubState(preset, "bell_fmRatio"));
    this->param_78_getPresetValue(getSubState(preset, "bell_inharmonicity"));
    this->param_79_getPresetValue(getSubState(preset, "bell_strike"));
    this->param_80_getPresetValue(getSubState(preset, "bell_brightness"));
    this->param_81_getPresetValue(getSubState(preset, "bell_drive"));
    this->param_82_getPresetValue(getSubState(preset, "bell_modeLevel"));
    this->param_83_getPresetValue(getSubState(preset, "bell_modeDecayMs"));
    this->param_84_getPresetValue(getSubState(preset, "bell_level"));
    this->param_85_getPresetValue(getSubState(preset, "bass_note"));
    this->param_86_getPresetValue(getSubState(preset, "bass_fmRatio"));
    this->param_87_getPresetValue(getSubState(preset, "bass_fmDecayMs"));
    this->param_88_getPresetValue(getSubState(preset, "bass_decayMs"));
    this->param_89_getPresetValue(getSubState(preset, "bass_fmIndex"));
    this->param_90_getPresetValue(getSubState(preset, "bass_feedback"));
    this->param_91_getPresetValue(getSubState(preset, "bass_attackMs"));
    this->param_92_getPresetValue(getSubState(preset, "bass_bendSemitones"));
    this->param_93_getPresetValue(getSubState(preset, "bass_drive"));
    this->param_94_getPresetValue(getSubState(preset, "bass_subLevel"));
    this->param_95_getPresetValue(getSubState(preset, "bass_brightness"));
    this->param_96_getPresetValue(getSubState(preset, "bass_level"));
    this->p_01->getPreset(getSubState(getSubState(preset, "__sps"), "kick_core"));
    this->p_02->getPreset(getSubState(getSubState(preset, "__sps"), "snare_core"));
    this->p_03->getPreset(getSubState(getSubState(preset, "__sps"), "hat_core"));
    this->p_04->getPreset(getSubState(getSubState(preset, "__sps"), "clap_core"));
    this->p_05->getPreset(getSubState(getSubState(preset, "__sps"), "tom_core"));
    this->p_06->getPreset(getSubState(getSubState(preset, "__sps"), "rim_core"));
    this->p_07->getPreset(getSubState(getSubState(preset, "__sps"), "bell_core"));
    this->p_08->getPreset(getSubState(getSubState(preset, "__sps"), "bass_core"));
}

void setPreset(MillisecondTime time, PatcherStateInterface& preset) {
    this->updateTime(time, (ENGINE*)nullptr);
    this->p_01->setPreset(time, getSubState(getSubState(preset, "__sps"), "kick_core"));
    this->p_02->setPreset(time, getSubState(getSubState(preset, "__sps"), "snare_core"));
    this->p_03->setPreset(time, getSubState(getSubState(preset, "__sps"), "hat_core"));
    this->p_04->setPreset(time, getSubState(getSubState(preset, "__sps"), "clap_core"));
    this->p_05->setPreset(time, getSubState(getSubState(preset, "__sps"), "tom_core"));
    this->p_06->setPreset(time, getSubState(getSubState(preset, "__sps"), "rim_core"));
    this->p_07->setPreset(time, getSubState(getSubState(preset, "__sps"), "bell_core"));
    this->p_08->setPreset(time, getSubState(getSubState(preset, "__sps"), "bass_core"));
    this->param_01_setPresetValue(getSubState(preset, "kick_baseHz"));
    this->param_02_setPresetValue(getSubState(preset, "kick_pitchAmount"));
    this->param_03_setPresetValue(getSubState(preset, "kick_pitchDecayMs"));
    this->param_04_setPresetValue(getSubState(preset, "kick_ampDecayMs"));
    this->param_05_setPresetValue(getSubState(preset, "kick_fmIndex"));
    this->param_06_setPresetValue(getSubState(preset, "kick_fmRatio"));
    this->param_07_setPresetValue(getSubState(preset, "kick_resonMix"));
    this->param_08_setPresetValue(getSubState(preset, "kick_resonHz"));
    this->param_09_setPresetValue(getSubState(preset, "kick_resonQ"));
    this->param_10_setPresetValue(getSubState(preset, "kick_clickLevel"));
    this->param_11_setPresetValue(getSubState(preset, "kick_drive"));
    this->param_12_setPresetValue(getSubState(preset, "kick_level"));
    this->param_13_setPresetValue(getSubState(preset, "snare_bodyHz"));
    this->param_14_setPresetValue(getSubState(preset, "snare_bodyBend"));
    this->param_15_setPresetValue(getSubState(preset, "snare_noiseDecayMs"));
    this->param_16_setPresetValue(getSubState(preset, "snare_bodyDecayMs"));
    this->param_17_setPresetValue(getSubState(preset, "snare_bodyFM"));
    this->param_18_setPresetValue(getSubState(preset, "snare_noiseHz"));
    this->param_19_setPresetValue(getSubState(preset, "snare_bodyLevel"));
    this->param_20_setPresetValue(getSubState(preset, "snare_noiseLevel"));
    this->param_21_setPresetValue(getSubState(preset, "snare_noiseQ"));
    this->param_22_setPresetValue(getSubState(preset, "snare_snap"));
    this->param_23_setPresetValue(getSubState(preset, "snare_drive"));
    this->param_24_setPresetValue(getSubState(preset, "snare_level"));
    this->param_25_setPresetValue(getSubState(preset, "hat_metalHz"));
    this->param_26_setPresetValue(getSubState(preset, "hat_inharmonicity"));
    this->param_27_setPresetValue(getSubState(preset, "hat_noiseDecayMs"));
    this->param_28_setPresetValue(getSubState(preset, "hat_decayMs"));
    this->param_29_setPresetValue(getSubState(preset, "hat_spread"));
    this->param_30_setPresetValue(getSubState(preset, "hat_filterHz"));
    this->param_31_setPresetValue(getSubState(preset, "hat_metalLevel"));
    this->param_32_setPresetValue(getSubState(preset, "hat_noiseLevel"));
    this->param_33_setPresetValue(getSubState(preset, "hat_filterQ"));
    this->param_34_setPresetValue(getSubState(preset, "hat_attack"));
    this->param_35_setPresetValue(getSubState(preset, "hat_drive"));
    this->param_36_setPresetValue(getSubState(preset, "hat_level"));
    this->param_37_setPresetValue(getSubState(preset, "clap_count"));
    this->param_38_setPresetValue(getSubState(preset, "clap_scatter"));
    this->param_39_setPresetValue(getSubState(preset, "clap_tailDecayMs"));
    this->param_40_setPresetValue(getSubState(preset, "clap_burstDecayMs"));
    this->param_41_setPresetValue(getSubState(preset, "clap_spacingMs"));
    this->param_42_setPresetValue(getSubState(preset, "clap_filterHz"));
    this->param_43_setPresetValue(getSubState(preset, "clap_balance"));
    this->param_44_setPresetValue(getSubState(preset, "clap_tailLevel"));
    this->param_45_setPresetValue(getSubState(preset, "clap_filterQ"));
    this->param_46_setPresetValue(getSubState(preset, "clap_brightness"));
    this->param_47_setPresetValue(getSubState(preset, "clap_drive"));
    this->param_48_setPresetValue(getSubState(preset, "clap_level"));
    this->param_49_setPresetValue(getSubState(preset, "tom_pitchHz"));
    this->param_50_setPresetValue(getSubState(preset, "tom_bendDecayMs"));
    this->param_51_setPresetValue(getSubState(preset, "tom_fmAmount"));
    this->param_52_setPresetValue(getSubState(preset, "tom_decayMs"));
    this->param_53_setPresetValue(getSubState(preset, "tom_bendHz"));
    this->param_54_setPresetValue(getSubState(preset, "tom_fmRatio"));
    this->param_55_setPresetValue(getSubState(preset, "tom_noiseLevel"));
    this->param_56_setPresetValue(getSubState(preset, "tom_noiseDecayMs"));
    this->param_57_setPresetValue(getSubState(preset, "tom_drive"));
    this->param_58_setPresetValue(getSubState(preset, "tom_modeRatio"));
    this->param_59_setPresetValue(getSubState(preset, "tom_modeLevel"));
    this->param_60_setPresetValue(getSubState(preset, "tom_level"));
    this->param_61_setPresetValue(getSubState(preset, "rim_pitchHz"));
    this->param_62_setPresetValue(getSubState(preset, "rim_modeLevel"));
    this->param_63_setPresetValue(getSubState(preset, "rim_clickLevel"));
    this->param_64_setPresetValue(getSubState(preset, "rim_decayMs"));
    this->param_65_setPresetValue(getSubState(preset, "rim_modeRatio"));
    this->param_66_setPresetValue(getSubState(preset, "rim_noiseDecayMs"));
    this->param_67_setPresetValue(getSubState(preset, "rim_fmAmount"));
    this->param_68_setPresetValue(getSubState(preset, "rim_fmRatio"));
    this->param_69_setPresetValue(getSubState(preset, "rim_drive"));
    this->param_70_setPresetValue(getSubState(preset, "rim_filterHz"));
    this->param_71_setPresetValue(getSubState(preset, "rim_filterQ"));
    this->param_72_setPresetValue(getSubState(preset, "rim_level"));
    this->param_73_setPresetValue(getSubState(preset, "bell_pitchHz"));
    this->param_74_setPresetValue(getSubState(preset, "bell_fmIndex"));
    this->param_75_setPresetValue(getSubState(preset, "bell_fmDecayMs"));
    this->param_76_setPresetValue(getSubState(preset, "bell_decayMs"));
    this->param_77_setPresetValue(getSubState(preset, "bell_fmRatio"));
    this->param_78_setPresetValue(getSubState(preset, "bell_inharmonicity"));
    this->param_79_setPresetValue(getSubState(preset, "bell_strike"));
    this->param_80_setPresetValue(getSubState(preset, "bell_brightness"));
    this->param_81_setPresetValue(getSubState(preset, "bell_drive"));
    this->param_82_setPresetValue(getSubState(preset, "bell_modeLevel"));
    this->param_83_setPresetValue(getSubState(preset, "bell_modeDecayMs"));
    this->param_84_setPresetValue(getSubState(preset, "bell_level"));
    this->param_85_setPresetValue(getSubState(preset, "bass_note"));
    this->param_86_setPresetValue(getSubState(preset, "bass_fmRatio"));
    this->param_87_setPresetValue(getSubState(preset, "bass_fmDecayMs"));
    this->param_88_setPresetValue(getSubState(preset, "bass_decayMs"));
    this->param_89_setPresetValue(getSubState(preset, "bass_fmIndex"));
    this->param_90_setPresetValue(getSubState(preset, "bass_feedback"));
    this->param_91_setPresetValue(getSubState(preset, "bass_attackMs"));
    this->param_92_setPresetValue(getSubState(preset, "bass_bendSemitones"));
    this->param_93_setPresetValue(getSubState(preset, "bass_drive"));
    this->param_94_setPresetValue(getSubState(preset, "bass_subLevel"));
    this->param_95_setPresetValue(getSubState(preset, "bass_brightness"));
    this->param_96_setPresetValue(getSubState(preset, "bass_level"));
}

void setParameterValue(ParameterIndex index, ParameterValue v, MillisecondTime time) {
    this->updateTime(time, (ENGINE*)nullptr);

    switch (index) {
    case 0:
        {
        this->param_01_value_set(v);
        break;
        }
    case 1:
        {
        this->param_02_value_set(v);
        break;
        }
    case 2:
        {
        this->param_03_value_set(v);
        break;
        }
    case 3:
        {
        this->param_04_value_set(v);
        break;
        }
    case 4:
        {
        this->param_05_value_set(v);
        break;
        }
    case 5:
        {
        this->param_06_value_set(v);
        break;
        }
    case 6:
        {
        this->param_07_value_set(v);
        break;
        }
    case 7:
        {
        this->param_08_value_set(v);
        break;
        }
    case 8:
        {
        this->param_09_value_set(v);
        break;
        }
    case 9:
        {
        this->param_10_value_set(v);
        break;
        }
    case 10:
        {
        this->param_11_value_set(v);
        break;
        }
    case 11:
        {
        this->param_12_value_set(v);
        break;
        }
    case 12:
        {
        this->param_13_value_set(v);
        break;
        }
    case 13:
        {
        this->param_14_value_set(v);
        break;
        }
    case 14:
        {
        this->param_15_value_set(v);
        break;
        }
    case 15:
        {
        this->param_16_value_set(v);
        break;
        }
    case 16:
        {
        this->param_17_value_set(v);
        break;
        }
    case 17:
        {
        this->param_18_value_set(v);
        break;
        }
    case 18:
        {
        this->param_19_value_set(v);
        break;
        }
    case 19:
        {
        this->param_20_value_set(v);
        break;
        }
    case 20:
        {
        this->param_21_value_set(v);
        break;
        }
    case 21:
        {
        this->param_22_value_set(v);
        break;
        }
    case 22:
        {
        this->param_23_value_set(v);
        break;
        }
    case 23:
        {
        this->param_24_value_set(v);
        break;
        }
    case 24:
        {
        this->param_25_value_set(v);
        break;
        }
    case 25:
        {
        this->param_26_value_set(v);
        break;
        }
    case 26:
        {
        this->param_27_value_set(v);
        break;
        }
    case 27:
        {
        this->param_28_value_set(v);
        break;
        }
    case 28:
        {
        this->param_29_value_set(v);
        break;
        }
    case 29:
        {
        this->param_30_value_set(v);
        break;
        }
    case 30:
        {
        this->param_31_value_set(v);
        break;
        }
    case 31:
        {
        this->param_32_value_set(v);
        break;
        }
    case 32:
        {
        this->param_33_value_set(v);
        break;
        }
    case 33:
        {
        this->param_34_value_set(v);
        break;
        }
    case 34:
        {
        this->param_35_value_set(v);
        break;
        }
    case 35:
        {
        this->param_36_value_set(v);
        break;
        }
    case 36:
        {
        this->param_37_value_set(v);
        break;
        }
    case 37:
        {
        this->param_38_value_set(v);
        break;
        }
    case 38:
        {
        this->param_39_value_set(v);
        break;
        }
    case 39:
        {
        this->param_40_value_set(v);
        break;
        }
    case 40:
        {
        this->param_41_value_set(v);
        break;
        }
    case 41:
        {
        this->param_42_value_set(v);
        break;
        }
    case 42:
        {
        this->param_43_value_set(v);
        break;
        }
    case 43:
        {
        this->param_44_value_set(v);
        break;
        }
    case 44:
        {
        this->param_45_value_set(v);
        break;
        }
    case 45:
        {
        this->param_46_value_set(v);
        break;
        }
    case 46:
        {
        this->param_47_value_set(v);
        break;
        }
    case 47:
        {
        this->param_48_value_set(v);
        break;
        }
    case 48:
        {
        this->param_49_value_set(v);
        break;
        }
    case 49:
        {
        this->param_50_value_set(v);
        break;
        }
    case 50:
        {
        this->param_51_value_set(v);
        break;
        }
    case 51:
        {
        this->param_52_value_set(v);
        break;
        }
    case 52:
        {
        this->param_53_value_set(v);
        break;
        }
    case 53:
        {
        this->param_54_value_set(v);
        break;
        }
    case 54:
        {
        this->param_55_value_set(v);
        break;
        }
    case 55:
        {
        this->param_56_value_set(v);
        break;
        }
    case 56:
        {
        this->param_57_value_set(v);
        break;
        }
    case 57:
        {
        this->param_58_value_set(v);
        break;
        }
    case 58:
        {
        this->param_59_value_set(v);
        break;
        }
    case 59:
        {
        this->param_60_value_set(v);
        break;
        }
    case 60:
        {
        this->param_61_value_set(v);
        break;
        }
    case 61:
        {
        this->param_62_value_set(v);
        break;
        }
    case 62:
        {
        this->param_63_value_set(v);
        break;
        }
    case 63:
        {
        this->param_64_value_set(v);
        break;
        }
    case 64:
        {
        this->param_65_value_set(v);
        break;
        }
    case 65:
        {
        this->param_66_value_set(v);
        break;
        }
    case 66:
        {
        this->param_67_value_set(v);
        break;
        }
    case 67:
        {
        this->param_68_value_set(v);
        break;
        }
    case 68:
        {
        this->param_69_value_set(v);
        break;
        }
    case 69:
        {
        this->param_70_value_set(v);
        break;
        }
    case 70:
        {
        this->param_71_value_set(v);
        break;
        }
    case 71:
        {
        this->param_72_value_set(v);
        break;
        }
    case 72:
        {
        this->param_73_value_set(v);
        break;
        }
    case 73:
        {
        this->param_74_value_set(v);
        break;
        }
    case 74:
        {
        this->param_75_value_set(v);
        break;
        }
    case 75:
        {
        this->param_76_value_set(v);
        break;
        }
    case 76:
        {
        this->param_77_value_set(v);
        break;
        }
    case 77:
        {
        this->param_78_value_set(v);
        break;
        }
    case 78:
        {
        this->param_79_value_set(v);
        break;
        }
    case 79:
        {
        this->param_80_value_set(v);
        break;
        }
    case 80:
        {
        this->param_81_value_set(v);
        break;
        }
    case 81:
        {
        this->param_82_value_set(v);
        break;
        }
    case 82:
        {
        this->param_83_value_set(v);
        break;
        }
    case 83:
        {
        this->param_84_value_set(v);
        break;
        }
    case 84:
        {
        this->param_85_value_set(v);
        break;
        }
    case 85:
        {
        this->param_86_value_set(v);
        break;
        }
    case 86:
        {
        this->param_87_value_set(v);
        break;
        }
    case 87:
        {
        this->param_88_value_set(v);
        break;
        }
    case 88:
        {
        this->param_89_value_set(v);
        break;
        }
    case 89:
        {
        this->param_90_value_set(v);
        break;
        }
    case 90:
        {
        this->param_91_value_set(v);
        break;
        }
    case 91:
        {
        this->param_92_value_set(v);
        break;
        }
    case 92:
        {
        this->param_93_value_set(v);
        break;
        }
    case 93:
        {
        this->param_94_value_set(v);
        break;
        }
    case 94:
        {
        this->param_95_value_set(v);
        break;
        }
    case 95:
        {
        this->param_96_value_set(v);
        break;
        }
    default:
        {
        index -= 96;

        if (index < this->p_01->getNumParameters())
            this->p_01->setParameterValue(index, v, time);

        index -= this->p_01->getNumParameters();

        if (index < this->p_02->getNumParameters())
            this->p_02->setParameterValue(index, v, time);

        index -= this->p_02->getNumParameters();

        if (index < this->p_03->getNumParameters())
            this->p_03->setParameterValue(index, v, time);

        index -= this->p_03->getNumParameters();

        if (index < this->p_04->getNumParameters())
            this->p_04->setParameterValue(index, v, time);

        index -= this->p_04->getNumParameters();

        if (index < this->p_05->getNumParameters())
            this->p_05->setParameterValue(index, v, time);

        index -= this->p_05->getNumParameters();

        if (index < this->p_06->getNumParameters())
            this->p_06->setParameterValue(index, v, time);

        index -= this->p_06->getNumParameters();

        if (index < this->p_07->getNumParameters())
            this->p_07->setParameterValue(index, v, time);

        index -= this->p_07->getNumParameters();

        if (index < this->p_08->getNumParameters())
            this->p_08->setParameterValue(index, v, time);

        break;
        }
    }
}

void processParameterEvent(ParameterIndex index, ParameterValue value, MillisecondTime time) {
    this->setParameterValue(index, value, time);
}

void processParameterBangEvent(ParameterIndex index, MillisecondTime time) {
    this->setParameterValue(index, this->getParameterValue(index), time);
}

void processNormalizedParameterEvent(ParameterIndex index, ParameterValue value, MillisecondTime time) {
    this->setParameterValueNormalized(index, value, time);
}

ParameterValue getParameterValue(ParameterIndex index)  {
    switch (index) {
    case 0:
        {
        return this->param_01_value;
        }
    case 1:
        {
        return this->param_02_value;
        }
    case 2:
        {
        return this->param_03_value;
        }
    case 3:
        {
        return this->param_04_value;
        }
    case 4:
        {
        return this->param_05_value;
        }
    case 5:
        {
        return this->param_06_value;
        }
    case 6:
        {
        return this->param_07_value;
        }
    case 7:
        {
        return this->param_08_value;
        }
    case 8:
        {
        return this->param_09_value;
        }
    case 9:
        {
        return this->param_10_value;
        }
    case 10:
        {
        return this->param_11_value;
        }
    case 11:
        {
        return this->param_12_value;
        }
    case 12:
        {
        return this->param_13_value;
        }
    case 13:
        {
        return this->param_14_value;
        }
    case 14:
        {
        return this->param_15_value;
        }
    case 15:
        {
        return this->param_16_value;
        }
    case 16:
        {
        return this->param_17_value;
        }
    case 17:
        {
        return this->param_18_value;
        }
    case 18:
        {
        return this->param_19_value;
        }
    case 19:
        {
        return this->param_20_value;
        }
    case 20:
        {
        return this->param_21_value;
        }
    case 21:
        {
        return this->param_22_value;
        }
    case 22:
        {
        return this->param_23_value;
        }
    case 23:
        {
        return this->param_24_value;
        }
    case 24:
        {
        return this->param_25_value;
        }
    case 25:
        {
        return this->param_26_value;
        }
    case 26:
        {
        return this->param_27_value;
        }
    case 27:
        {
        return this->param_28_value;
        }
    case 28:
        {
        return this->param_29_value;
        }
    case 29:
        {
        return this->param_30_value;
        }
    case 30:
        {
        return this->param_31_value;
        }
    case 31:
        {
        return this->param_32_value;
        }
    case 32:
        {
        return this->param_33_value;
        }
    case 33:
        {
        return this->param_34_value;
        }
    case 34:
        {
        return this->param_35_value;
        }
    case 35:
        {
        return this->param_36_value;
        }
    case 36:
        {
        return this->param_37_value;
        }
    case 37:
        {
        return this->param_38_value;
        }
    case 38:
        {
        return this->param_39_value;
        }
    case 39:
        {
        return this->param_40_value;
        }
    case 40:
        {
        return this->param_41_value;
        }
    case 41:
        {
        return this->param_42_value;
        }
    case 42:
        {
        return this->param_43_value;
        }
    case 43:
        {
        return this->param_44_value;
        }
    case 44:
        {
        return this->param_45_value;
        }
    case 45:
        {
        return this->param_46_value;
        }
    case 46:
        {
        return this->param_47_value;
        }
    case 47:
        {
        return this->param_48_value;
        }
    case 48:
        {
        return this->param_49_value;
        }
    case 49:
        {
        return this->param_50_value;
        }
    case 50:
        {
        return this->param_51_value;
        }
    case 51:
        {
        return this->param_52_value;
        }
    case 52:
        {
        return this->param_53_value;
        }
    case 53:
        {
        return this->param_54_value;
        }
    case 54:
        {
        return this->param_55_value;
        }
    case 55:
        {
        return this->param_56_value;
        }
    case 56:
        {
        return this->param_57_value;
        }
    case 57:
        {
        return this->param_58_value;
        }
    case 58:
        {
        return this->param_59_value;
        }
    case 59:
        {
        return this->param_60_value;
        }
    case 60:
        {
        return this->param_61_value;
        }
    case 61:
        {
        return this->param_62_value;
        }
    case 62:
        {
        return this->param_63_value;
        }
    case 63:
        {
        return this->param_64_value;
        }
    case 64:
        {
        return this->param_65_value;
        }
    case 65:
        {
        return this->param_66_value;
        }
    case 66:
        {
        return this->param_67_value;
        }
    case 67:
        {
        return this->param_68_value;
        }
    case 68:
        {
        return this->param_69_value;
        }
    case 69:
        {
        return this->param_70_value;
        }
    case 70:
        {
        return this->param_71_value;
        }
    case 71:
        {
        return this->param_72_value;
        }
    case 72:
        {
        return this->param_73_value;
        }
    case 73:
        {
        return this->param_74_value;
        }
    case 74:
        {
        return this->param_75_value;
        }
    case 75:
        {
        return this->param_76_value;
        }
    case 76:
        {
        return this->param_77_value;
        }
    case 77:
        {
        return this->param_78_value;
        }
    case 78:
        {
        return this->param_79_value;
        }
    case 79:
        {
        return this->param_80_value;
        }
    case 80:
        {
        return this->param_81_value;
        }
    case 81:
        {
        return this->param_82_value;
        }
    case 82:
        {
        return this->param_83_value;
        }
    case 83:
        {
        return this->param_84_value;
        }
    case 84:
        {
        return this->param_85_value;
        }
    case 85:
        {
        return this->param_86_value;
        }
    case 86:
        {
        return this->param_87_value;
        }
    case 87:
        {
        return this->param_88_value;
        }
    case 88:
        {
        return this->param_89_value;
        }
    case 89:
        {
        return this->param_90_value;
        }
    case 90:
        {
        return this->param_91_value;
        }
    case 91:
        {
        return this->param_92_value;
        }
    case 92:
        {
        return this->param_93_value;
        }
    case 93:
        {
        return this->param_94_value;
        }
    case 94:
        {
        return this->param_95_value;
        }
    case 95:
        {
        return this->param_96_value;
        }
    default:
        {
        index -= 96;

        if (index < this->p_01->getNumParameters())
            return this->p_01->getParameterValue(index);

        index -= this->p_01->getNumParameters();

        if (index < this->p_02->getNumParameters())
            return this->p_02->getParameterValue(index);

        index -= this->p_02->getNumParameters();

        if (index < this->p_03->getNumParameters())
            return this->p_03->getParameterValue(index);

        index -= this->p_03->getNumParameters();

        if (index < this->p_04->getNumParameters())
            return this->p_04->getParameterValue(index);

        index -= this->p_04->getNumParameters();

        if (index < this->p_05->getNumParameters())
            return this->p_05->getParameterValue(index);

        index -= this->p_05->getNumParameters();

        if (index < this->p_06->getNumParameters())
            return this->p_06->getParameterValue(index);

        index -= this->p_06->getNumParameters();

        if (index < this->p_07->getNumParameters())
            return this->p_07->getParameterValue(index);

        index -= this->p_07->getNumParameters();

        if (index < this->p_08->getNumParameters())
            return this->p_08->getParameterValue(index);

        return 0;
        }
    }
}

ParameterIndex getNumSignalInParameters() const {
    return 0;
}

ParameterIndex getNumSignalOutParameters() const {
    return 0;
}

ParameterIndex getNumParameters() const {
    return 96 + this->p_01->getNumParameters() + this->p_02->getNumParameters() + this->p_03->getNumParameters() + this->p_04->getNumParameters() + this->p_05->getNumParameters() + this->p_06->getNumParameters() + this->p_07->getNumParameters() + this->p_08->getNumParameters();
}

ConstCharPointer getParameterName(ParameterIndex index) const {
    switch (index) {
    case 0:
        {
        return "kick_baseHz";
        }
    case 1:
        {
        return "kick_pitchAmount";
        }
    case 2:
        {
        return "kick_pitchDecayMs";
        }
    case 3:
        {
        return "kick_ampDecayMs";
        }
    case 4:
        {
        return "kick_fmIndex";
        }
    case 5:
        {
        return "kick_fmRatio";
        }
    case 6:
        {
        return "kick_resonMix";
        }
    case 7:
        {
        return "kick_resonHz";
        }
    case 8:
        {
        return "kick_resonQ";
        }
    case 9:
        {
        return "kick_clickLevel";
        }
    case 10:
        {
        return "kick_drive";
        }
    case 11:
        {
        return "kick_level";
        }
    case 12:
        {
        return "snare_bodyHz";
        }
    case 13:
        {
        return "snare_bodyBend";
        }
    case 14:
        {
        return "snare_noiseDecayMs";
        }
    case 15:
        {
        return "snare_bodyDecayMs";
        }
    case 16:
        {
        return "snare_bodyFM";
        }
    case 17:
        {
        return "snare_noiseHz";
        }
    case 18:
        {
        return "snare_bodyLevel";
        }
    case 19:
        {
        return "snare_noiseLevel";
        }
    case 20:
        {
        return "snare_noiseQ";
        }
    case 21:
        {
        return "snare_snap";
        }
    case 22:
        {
        return "snare_drive";
        }
    case 23:
        {
        return "snare_level";
        }
    case 24:
        {
        return "hat_metalHz";
        }
    case 25:
        {
        return "hat_inharmonicity";
        }
    case 26:
        {
        return "hat_noiseDecayMs";
        }
    case 27:
        {
        return "hat_decayMs";
        }
    case 28:
        {
        return "hat_spread";
        }
    case 29:
        {
        return "hat_filterHz";
        }
    case 30:
        {
        return "hat_metalLevel";
        }
    case 31:
        {
        return "hat_noiseLevel";
        }
    case 32:
        {
        return "hat_filterQ";
        }
    case 33:
        {
        return "hat_attack";
        }
    case 34:
        {
        return "hat_drive";
        }
    case 35:
        {
        return "hat_level";
        }
    case 36:
        {
        return "clap_count";
        }
    case 37:
        {
        return "clap_scatter";
        }
    case 38:
        {
        return "clap_tailDecayMs";
        }
    case 39:
        {
        return "clap_burstDecayMs";
        }
    case 40:
        {
        return "clap_spacingMs";
        }
    case 41:
        {
        return "clap_filterHz";
        }
    case 42:
        {
        return "clap_balance";
        }
    case 43:
        {
        return "clap_tailLevel";
        }
    case 44:
        {
        return "clap_filterQ";
        }
    case 45:
        {
        return "clap_brightness";
        }
    case 46:
        {
        return "clap_drive";
        }
    case 47:
        {
        return "clap_level";
        }
    case 48:
        {
        return "tom_pitchHz";
        }
    case 49:
        {
        return "tom_bendDecayMs";
        }
    case 50:
        {
        return "tom_fmAmount";
        }
    case 51:
        {
        return "tom_decayMs";
        }
    case 52:
        {
        return "tom_bendHz";
        }
    case 53:
        {
        return "tom_fmRatio";
        }
    case 54:
        {
        return "tom_noiseLevel";
        }
    case 55:
        {
        return "tom_noiseDecayMs";
        }
    case 56:
        {
        return "tom_drive";
        }
    case 57:
        {
        return "tom_modeRatio";
        }
    case 58:
        {
        return "tom_modeLevel";
        }
    case 59:
        {
        return "tom_level";
        }
    case 60:
        {
        return "rim_pitchHz";
        }
    case 61:
        {
        return "rim_modeLevel";
        }
    case 62:
        {
        return "rim_clickLevel";
        }
    case 63:
        {
        return "rim_decayMs";
        }
    case 64:
        {
        return "rim_modeRatio";
        }
    case 65:
        {
        return "rim_noiseDecayMs";
        }
    case 66:
        {
        return "rim_fmAmount";
        }
    case 67:
        {
        return "rim_fmRatio";
        }
    case 68:
        {
        return "rim_drive";
        }
    case 69:
        {
        return "rim_filterHz";
        }
    case 70:
        {
        return "rim_filterQ";
        }
    case 71:
        {
        return "rim_level";
        }
    case 72:
        {
        return "bell_pitchHz";
        }
    case 73:
        {
        return "bell_fmIndex";
        }
    case 74:
        {
        return "bell_fmDecayMs";
        }
    case 75:
        {
        return "bell_decayMs";
        }
    case 76:
        {
        return "bell_fmRatio";
        }
    case 77:
        {
        return "bell_inharmonicity";
        }
    case 78:
        {
        return "bell_strike";
        }
    case 79:
        {
        return "bell_brightness";
        }
    case 80:
        {
        return "bell_drive";
        }
    case 81:
        {
        return "bell_modeLevel";
        }
    case 82:
        {
        return "bell_modeDecayMs";
        }
    case 83:
        {
        return "bell_level";
        }
    case 84:
        {
        return "bass_note";
        }
    case 85:
        {
        return "bass_fmRatio";
        }
    case 86:
        {
        return "bass_fmDecayMs";
        }
    case 87:
        {
        return "bass_decayMs";
        }
    case 88:
        {
        return "bass_fmIndex";
        }
    case 89:
        {
        return "bass_feedback";
        }
    case 90:
        {
        return "bass_attackMs";
        }
    case 91:
        {
        return "bass_bendSemitones";
        }
    case 92:
        {
        return "bass_drive";
        }
    case 93:
        {
        return "bass_subLevel";
        }
    case 94:
        {
        return "bass_brightness";
        }
    case 95:
        {
        return "bass_level";
        }
    default:
        {
        index -= 96;

        if (index < this->p_01->getNumParameters())
            return this->p_01->getParameterName(index);

        index -= this->p_01->getNumParameters();

        if (index < this->p_02->getNumParameters())
            return this->p_02->getParameterName(index);

        index -= this->p_02->getNumParameters();

        if (index < this->p_03->getNumParameters())
            return this->p_03->getParameterName(index);

        index -= this->p_03->getNumParameters();

        if (index < this->p_04->getNumParameters())
            return this->p_04->getParameterName(index);

        index -= this->p_04->getNumParameters();

        if (index < this->p_05->getNumParameters())
            return this->p_05->getParameterName(index);

        index -= this->p_05->getNumParameters();

        if (index < this->p_06->getNumParameters())
            return this->p_06->getParameterName(index);

        index -= this->p_06->getNumParameters();

        if (index < this->p_07->getNumParameters())
            return this->p_07->getParameterName(index);

        index -= this->p_07->getNumParameters();

        if (index < this->p_08->getNumParameters())
            return this->p_08->getParameterName(index);

        return "bogus";
        }
    }
}

ConstCharPointer getParameterId(ParameterIndex index) const {
    switch (index) {
    case 0:
        {
        return "kick_baseHz";
        }
    case 1:
        {
        return "kick_pitchAmount";
        }
    case 2:
        {
        return "kick_pitchDecayMs";
        }
    case 3:
        {
        return "kick_ampDecayMs";
        }
    case 4:
        {
        return "kick_fmIndex";
        }
    case 5:
        {
        return "kick_fmRatio";
        }
    case 6:
        {
        return "kick_resonMix";
        }
    case 7:
        {
        return "kick_resonHz";
        }
    case 8:
        {
        return "kick_resonQ";
        }
    case 9:
        {
        return "kick_clickLevel";
        }
    case 10:
        {
        return "kick_drive";
        }
    case 11:
        {
        return "kick_level";
        }
    case 12:
        {
        return "snare_bodyHz";
        }
    case 13:
        {
        return "snare_bodyBend";
        }
    case 14:
        {
        return "snare_noiseDecayMs";
        }
    case 15:
        {
        return "snare_bodyDecayMs";
        }
    case 16:
        {
        return "snare_bodyFM";
        }
    case 17:
        {
        return "snare_noiseHz";
        }
    case 18:
        {
        return "snare_bodyLevel";
        }
    case 19:
        {
        return "snare_noiseLevel";
        }
    case 20:
        {
        return "snare_noiseQ";
        }
    case 21:
        {
        return "snare_snap";
        }
    case 22:
        {
        return "snare_drive";
        }
    case 23:
        {
        return "snare_level";
        }
    case 24:
        {
        return "hat_metalHz";
        }
    case 25:
        {
        return "hat_inharmonicity";
        }
    case 26:
        {
        return "hat_noiseDecayMs";
        }
    case 27:
        {
        return "hat_decayMs";
        }
    case 28:
        {
        return "hat_spread";
        }
    case 29:
        {
        return "hat_filterHz";
        }
    case 30:
        {
        return "hat_metalLevel";
        }
    case 31:
        {
        return "hat_noiseLevel";
        }
    case 32:
        {
        return "hat_filterQ";
        }
    case 33:
        {
        return "hat_attack";
        }
    case 34:
        {
        return "hat_drive";
        }
    case 35:
        {
        return "hat_level";
        }
    case 36:
        {
        return "clap_count";
        }
    case 37:
        {
        return "clap_scatter";
        }
    case 38:
        {
        return "clap_tailDecayMs";
        }
    case 39:
        {
        return "clap_burstDecayMs";
        }
    case 40:
        {
        return "clap_spacingMs";
        }
    case 41:
        {
        return "clap_filterHz";
        }
    case 42:
        {
        return "clap_balance";
        }
    case 43:
        {
        return "clap_tailLevel";
        }
    case 44:
        {
        return "clap_filterQ";
        }
    case 45:
        {
        return "clap_brightness";
        }
    case 46:
        {
        return "clap_drive";
        }
    case 47:
        {
        return "clap_level";
        }
    case 48:
        {
        return "tom_pitchHz";
        }
    case 49:
        {
        return "tom_bendDecayMs";
        }
    case 50:
        {
        return "tom_fmAmount";
        }
    case 51:
        {
        return "tom_decayMs";
        }
    case 52:
        {
        return "tom_bendHz";
        }
    case 53:
        {
        return "tom_fmRatio";
        }
    case 54:
        {
        return "tom_noiseLevel";
        }
    case 55:
        {
        return "tom_noiseDecayMs";
        }
    case 56:
        {
        return "tom_drive";
        }
    case 57:
        {
        return "tom_modeRatio";
        }
    case 58:
        {
        return "tom_modeLevel";
        }
    case 59:
        {
        return "tom_level";
        }
    case 60:
        {
        return "rim_pitchHz";
        }
    case 61:
        {
        return "rim_modeLevel";
        }
    case 62:
        {
        return "rim_clickLevel";
        }
    case 63:
        {
        return "rim_decayMs";
        }
    case 64:
        {
        return "rim_modeRatio";
        }
    case 65:
        {
        return "rim_noiseDecayMs";
        }
    case 66:
        {
        return "rim_fmAmount";
        }
    case 67:
        {
        return "rim_fmRatio";
        }
    case 68:
        {
        return "rim_drive";
        }
    case 69:
        {
        return "rim_filterHz";
        }
    case 70:
        {
        return "rim_filterQ";
        }
    case 71:
        {
        return "rim_level";
        }
    case 72:
        {
        return "bell_pitchHz";
        }
    case 73:
        {
        return "bell_fmIndex";
        }
    case 74:
        {
        return "bell_fmDecayMs";
        }
    case 75:
        {
        return "bell_decayMs";
        }
    case 76:
        {
        return "bell_fmRatio";
        }
    case 77:
        {
        return "bell_inharmonicity";
        }
    case 78:
        {
        return "bell_strike";
        }
    case 79:
        {
        return "bell_brightness";
        }
    case 80:
        {
        return "bell_drive";
        }
    case 81:
        {
        return "bell_modeLevel";
        }
    case 82:
        {
        return "bell_modeDecayMs";
        }
    case 83:
        {
        return "bell_level";
        }
    case 84:
        {
        return "bass_note";
        }
    case 85:
        {
        return "bass_fmRatio";
        }
    case 86:
        {
        return "bass_fmDecayMs";
        }
    case 87:
        {
        return "bass_decayMs";
        }
    case 88:
        {
        return "bass_fmIndex";
        }
    case 89:
        {
        return "bass_feedback";
        }
    case 90:
        {
        return "bass_attackMs";
        }
    case 91:
        {
        return "bass_bendSemitones";
        }
    case 92:
        {
        return "bass_drive";
        }
    case 93:
        {
        return "bass_subLevel";
        }
    case 94:
        {
        return "bass_brightness";
        }
    case 95:
        {
        return "bass_level";
        }
    default:
        {
        index -= 96;

        if (index < this->p_01->getNumParameters())
            return this->p_01->getParameterId(index);

        index -= this->p_01->getNumParameters();

        if (index < this->p_02->getNumParameters())
            return this->p_02->getParameterId(index);

        index -= this->p_02->getNumParameters();

        if (index < this->p_03->getNumParameters())
            return this->p_03->getParameterId(index);

        index -= this->p_03->getNumParameters();

        if (index < this->p_04->getNumParameters())
            return this->p_04->getParameterId(index);

        index -= this->p_04->getNumParameters();

        if (index < this->p_05->getNumParameters())
            return this->p_05->getParameterId(index);

        index -= this->p_05->getNumParameters();

        if (index < this->p_06->getNumParameters())
            return this->p_06->getParameterId(index);

        index -= this->p_06->getNumParameters();

        if (index < this->p_07->getNumParameters())
            return this->p_07->getParameterId(index);

        index -= this->p_07->getNumParameters();

        if (index < this->p_08->getNumParameters())
            return this->p_08->getParameterId(index);

        return "bogus";
        }
    }
}

void getParameterInfo(ParameterIndex index, ParameterInfo * info) const {
    {
        switch (index) {
        case 0:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 48;
            info->min = 10;
            info->max = 2000;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "Hz";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 1:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 150;
            info->min = 0;
            info->max = 600;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "Hz";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 2:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 32;
            info->min = 1;
            info->max = 300;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "ms";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 3:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 620;
            info->min = 1;
            info->max = 30000;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "ms";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 4:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.15;
            info->min = 0;
            info->max = 32;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 5:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 1.5;
            info->min = 0.125;
            info->max = 8;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 6:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.22;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 7:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 58;
            info->min = 25;
            info->max = 400;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "Hz";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 8:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 8;
            info->min = 0.5;
            info->max = 24;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 9:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.08;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 10:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 1.8;
            info->min = 0.25;
            info->max = 8;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 11:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.5;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 12:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 180;
            info->min = 40;
            info->max = 1200;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "Hz";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 13:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 90;
            info->min = 0;
            info->max = 1200;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "Hz";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 14:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 260;
            info->min = 5;
            info->max = 10000;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "ms";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 15:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 180;
            info->min = 5;
            info->max = 5000;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "ms";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 16:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.35;
            info->min = 0;
            info->max = 16;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 17:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 3500;
            info->min = 100;
            info->max = 18000;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "Hz";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 18:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.65;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 19:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.72;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 20:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 1.1;
            info->min = 0.5;
            info->max = 20;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 21:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.45;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 22:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 1.7;
            info->min = 0.25;
            info->max = 8;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 23:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.45;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 24:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 700;
            info->min = 100;
            info->max = 6000;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "Hz";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 25:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.65;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 26:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 85;
            info->min = 5;
            info->max = 10000;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "ms";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 27:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 120;
            info->min = 5;
            info->max = 10000;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "ms";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 28:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 1;
            info->min = 0.1;
            info->max = 4;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 29:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 6500;
            info->min = 100;
            info->max = 18000;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "Hz";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 30:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.7;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 31:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.55;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 32:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.8;
            info->min = 0.5;
            info->max = 20;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 33:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.4;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 34:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 1.4;
            info->min = 0.25;
            info->max = 8;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 35:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.4;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 36:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 3;
            info->min = 1;
            info->max = 8;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 37:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.15;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 38:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 280;
            info->min = 5;
            info->max = 10000;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "ms";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 39:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 10;
            info->min = 1;
            info->max = 200;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "ms";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 40:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 12;
            info->min = 2;
            info->max = 100;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "ms";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 41:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 1600;
            info->min = 100;
            info->max = 18000;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "Hz";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 42:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.45;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 43:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.65;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 44:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 1.1;
            info->min = 0.5;
            info->max = 20;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 45:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.2;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 46:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 1.5;
            info->min = 0.25;
            info->max = 8;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 47:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.5;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 48:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 140;
            info->min = 30;
            info->max = 1600;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "Hz";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 49:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 35;
            info->min = 1;
            info->max = 500;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "ms";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 50:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.5;
            info->min = 0;
            info->max = 10;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 51:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 450;
            info->min = 10;
            info->max = 6000;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "ms";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 52:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 160;
            info->min = 0;
            info->max = 1200;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "Hz";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 53:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 1.5;
            info->min = 0.25;
            info->max = 8;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 54:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.08;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 55:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 12;
            info->min = 1;
            info->max = 500;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "ms";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 56:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 1.3;
            info->min = 0.25;
            info->max = 8;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 57:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 1.59;
            info->min = 1;
            info->max = 5;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 58:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.25;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 59:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.5;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 60:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 850;
            info->min = 100;
            info->max = 6000;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "Hz";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 61:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.65;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 62:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.6;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 63:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 65;
            info->min = 1;
            info->max = 2000;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "ms";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 64:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 2.73;
            info->min = 1;
            info->max = 8;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 65:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 4;
            info->min = 0.5;
            info->max = 300;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "ms";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 66:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.2;
            info->min = 0;
            info->max = 8;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 67:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 2;
            info->min = 0.25;
            info->max = 8;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 68:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 1.8;
            info->min = 0.25;
            info->max = 8;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 69:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 4200;
            info->min = 200;
            info->max = 18000;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "Hz";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 70:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 1.2;
            info->min = 0.5;
            info->max = 15;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 71:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.45;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 72:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 440;
            info->min = 40;
            info->max = 4000;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "Hz";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 73:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 3;
            info->min = 0;
            info->max = 16;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 74:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 700;
            info->min = 5;
            info->max = 15000;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "ms";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 75:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 1600;
            info->min = 20;
            info->max = 15000;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "ms";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 76:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 2.71;
            info->min = 0.25;
            info->max = 12;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 77:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.4;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 78:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.2;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 79:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.65;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 80:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 1;
            info->min = 0.25;
            info->max = 6;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 81:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.3;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 82:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 900;
            info->min = 10;
            info->max = 15000;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "ms";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 83:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.35;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 84:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 36;
            info->min = 12;
            info->max = 96;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "MIDI";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 85:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 1;
            info->min = 0.25;
            info->max = 8;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 86:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 220;
            info->min = 5;
            info->max = 6000;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "ms";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 87:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 550;
            info->min = 10;
            info->max = 12000;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "ms";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 88:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 1.2;
            info->min = 0;
            info->max = 12;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 89:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.15;
            info->min = 0;
            info->max = 0.95;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 90:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 2;
            info->min = 0.2;
            info->max = 1000;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "ms";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 91:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0;
            info->min = -24;
            info->max = 24;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "st";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 92:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 1.4;
            info->min = 0.25;
            info->max = 8;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 93:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.35;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 94:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.6;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        case 95:
            {
            info->type = ParameterTypeNumber;
            info->initialValue = 0.45;
            info->min = 0;
            info->max = 1;
            info->exponent = 1;
            info->steps = 0;
            info->debug = false;
            info->saveable = true;
            info->transmittable = true;
            info->initialized = true;
            info->visible = true;
            info->displayName = "";
            info->unit = "";
            info->ioType = IOTypeUndefined;
            info->signalIndex = INVALID_INDEX;
            break;
            }
        default:
            {
            index -= 96;

            if (index < this->p_01->getNumParameters())
                this->p_01->getParameterInfo(index, info);

            index -= this->p_01->getNumParameters();

            if (index < this->p_02->getNumParameters())
                this->p_02->getParameterInfo(index, info);

            index -= this->p_02->getNumParameters();

            if (index < this->p_03->getNumParameters())
                this->p_03->getParameterInfo(index, info);

            index -= this->p_03->getNumParameters();

            if (index < this->p_04->getNumParameters())
                this->p_04->getParameterInfo(index, info);

            index -= this->p_04->getNumParameters();

            if (index < this->p_05->getNumParameters())
                this->p_05->getParameterInfo(index, info);

            index -= this->p_05->getNumParameters();

            if (index < this->p_06->getNumParameters())
                this->p_06->getParameterInfo(index, info);

            index -= this->p_06->getNumParameters();

            if (index < this->p_07->getNumParameters())
                this->p_07->getParameterInfo(index, info);

            index -= this->p_07->getNumParameters();

            if (index < this->p_08->getNumParameters())
                this->p_08->getParameterInfo(index, info);

            break;
            }
        }
    }
}

ParameterValue applyStepsToNormalizedParameterValue(ParameterValue normalizedValue, int steps) const {
    if (steps == 1) {
        if (normalizedValue > 0) {
            normalizedValue = 1.;
        }
    } else {
        ParameterValue oneStep = (number)1. / (steps - 1);
        ParameterValue numberOfSteps = rnbo_fround(normalizedValue / oneStep * 1 / (number)1) * (number)1;
        normalizedValue = numberOfSteps * oneStep;
    }

    return normalizedValue;
}

ParameterValue convertToNormalizedParameterValue(ParameterIndex index, ParameterValue value) const {
    switch (index) {
    case 6:
    case 9:
    case 11:
    case 18:
    case 19:
    case 21:
    case 23:
    case 25:
    case 30:
    case 31:
    case 33:
    case 35:
    case 37:
    case 42:
    case 43:
    case 45:
    case 47:
    case 54:
    case 58:
    case 59:
    case 61:
    case 62:
    case 71:
    case 77:
    case 78:
    case 79:
    case 81:
    case 83:
    case 93:
    case 94:
    case 95:
        {
        {
            value = (value < 0 ? 0 : (value > 1 ? 1 : value));
            ParameterValue normalizedValue = (value - 0) / (1 - 0);
            return normalizedValue;
        }
        }
    case 66:
        {
        {
            value = (value < 0 ? 0 : (value > 8 ? 8 : value));
            ParameterValue normalizedValue = (value - 0) / (8 - 0);
            return normalizedValue;
        }
        }
    case 50:
        {
        {
            value = (value < 0 ? 0 : (value > 10 ? 10 : value));
            ParameterValue normalizedValue = (value - 0) / (10 - 0);
            return normalizedValue;
        }
        }
    case 88:
        {
        {
            value = (value < 0 ? 0 : (value > 12 ? 12 : value));
            ParameterValue normalizedValue = (value - 0) / (12 - 0);
            return normalizedValue;
        }
        }
    case 16:
    case 73:
        {
        {
            value = (value < 0 ? 0 : (value > 16 ? 16 : value));
            ParameterValue normalizedValue = (value - 0) / (16 - 0);
            return normalizedValue;
        }
        }
    case 4:
        {
        {
            value = (value < 0 ? 0 : (value > 32 ? 32 : value));
            ParameterValue normalizedValue = (value - 0) / (32 - 0);
            return normalizedValue;
        }
        }
    case 1:
        {
        {
            value = (value < 0 ? 0 : (value > 600 ? 600 : value));
            ParameterValue normalizedValue = (value - 0) / (600 - 0);
            return normalizedValue;
        }
        }
    case 13:
    case 52:
        {
        {
            value = (value < 0 ? 0 : (value > 1200 ? 1200 : value));
            ParameterValue normalizedValue = (value - 0) / (1200 - 0);
            return normalizedValue;
        }
        }
    case 89:
        {
        {
            value = (value < 0 ? 0 : (value > 0.95 ? 0.95 : value));
            ParameterValue normalizedValue = (value - 0) / (0.95 - 0);
            return normalizedValue;
        }
        }
    case 57:
        {
        {
            value = (value < 1 ? 1 : (value > 5 ? 5 : value));
            ParameterValue normalizedValue = (value - 1) / (5 - 1);
            return normalizedValue;
        }
        }
    case 36:
    case 64:
        {
        {
            value = (value < 1 ? 1 : (value > 8 ? 8 : value));
            ParameterValue normalizedValue = (value - 1) / (8 - 1);
            return normalizedValue;
        }
        }
    case 39:
        {
        {
            value = (value < 1 ? 1 : (value > 200 ? 200 : value));
            ParameterValue normalizedValue = (value - 1) / (200 - 1);
            return normalizedValue;
        }
        }
    case 2:
        {
        {
            value = (value < 1 ? 1 : (value > 300 ? 300 : value));
            ParameterValue normalizedValue = (value - 1) / (300 - 1);
            return normalizedValue;
        }
        }
    case 49:
    case 55:
        {
        {
            value = (value < 1 ? 1 : (value > 500 ? 500 : value));
            ParameterValue normalizedValue = (value - 1) / (500 - 1);
            return normalizedValue;
        }
        }
    case 63:
        {
        {
            value = (value < 1 ? 1 : (value > 2000 ? 2000 : value));
            ParameterValue normalizedValue = (value - 1) / (2000 - 1);
            return normalizedValue;
        }
        }
    case 3:
        {
        {
            value = (value < 1 ? 1 : (value > 30000 ? 30000 : value));
            ParameterValue normalizedValue = (value - 1) / (30000 - 1);
            return normalizedValue;
        }
        }
    case 40:
        {
        {
            value = (value < 2 ? 2 : (value > 100 ? 100 : value));
            ParameterValue normalizedValue = (value - 2) / (100 - 2);
            return normalizedValue;
        }
        }
    case 15:
        {
        {
            value = (value < 5 ? 5 : (value > 5000 ? 5000 : value));
            ParameterValue normalizedValue = (value - 5) / (5000 - 5);
            return normalizedValue;
        }
        }
    case 86:
        {
        {
            value = (value < 5 ? 5 : (value > 6000 ? 6000 : value));
            ParameterValue normalizedValue = (value - 5) / (6000 - 5);
            return normalizedValue;
        }
        }
    case 14:
    case 26:
    case 27:
    case 38:
        {
        {
            value = (value < 5 ? 5 : (value > 10000 ? 10000 : value));
            ParameterValue normalizedValue = (value - 5) / (10000 - 5);
            return normalizedValue;
        }
        }
    case 74:
        {
        {
            value = (value < 5 ? 5 : (value > 15000 ? 15000 : value));
            ParameterValue normalizedValue = (value - 5) / (15000 - 5);
            return normalizedValue;
        }
        }
    case 0:
        {
        {
            value = (value < 10 ? 10 : (value > 2000 ? 2000 : value));
            ParameterValue normalizedValue = (value - 10) / (2000 - 10);
            return normalizedValue;
        }
        }
    case 51:
        {
        {
            value = (value < 10 ? 10 : (value > 6000 ? 6000 : value));
            ParameterValue normalizedValue = (value - 10) / (6000 - 10);
            return normalizedValue;
        }
        }
    case 87:
        {
        {
            value = (value < 10 ? 10 : (value > 12000 ? 12000 : value));
            ParameterValue normalizedValue = (value - 10) / (12000 - 10);
            return normalizedValue;
        }
        }
    case 82:
        {
        {
            value = (value < 10 ? 10 : (value > 15000 ? 15000 : value));
            ParameterValue normalizedValue = (value - 10) / (15000 - 10);
            return normalizedValue;
        }
        }
    case 84:
        {
        {
            value = (value < 12 ? 12 : (value > 96 ? 96 : value));
            ParameterValue normalizedValue = (value - 12) / (96 - 12);
            return normalizedValue;
        }
        }
    case 75:
        {
        {
            value = (value < 20 ? 20 : (value > 15000 ? 15000 : value));
            ParameterValue normalizedValue = (value - 20) / (15000 - 20);
            return normalizedValue;
        }
        }
    case 7:
        {
        {
            value = (value < 25 ? 25 : (value > 400 ? 400 : value));
            ParameterValue normalizedValue = (value - 25) / (400 - 25);
            return normalizedValue;
        }
        }
    case 48:
        {
        {
            value = (value < 30 ? 30 : (value > 1600 ? 1600 : value));
            ParameterValue normalizedValue = (value - 30) / (1600 - 30);
            return normalizedValue;
        }
        }
    case 12:
        {
        {
            value = (value < 40 ? 40 : (value > 1200 ? 1200 : value));
            ParameterValue normalizedValue = (value - 40) / (1200 - 40);
            return normalizedValue;
        }
        }
    case 72:
        {
        {
            value = (value < 40 ? 40 : (value > 4000 ? 4000 : value));
            ParameterValue normalizedValue = (value - 40) / (4000 - 40);
            return normalizedValue;
        }
        }
    case 24:
    case 60:
        {
        {
            value = (value < 100 ? 100 : (value > 6000 ? 6000 : value));
            ParameterValue normalizedValue = (value - 100) / (6000 - 100);
            return normalizedValue;
        }
        }
    case 17:
    case 29:
    case 41:
        {
        {
            value = (value < 100 ? 100 : (value > 18000 ? 18000 : value));
            ParameterValue normalizedValue = (value - 100) / (18000 - 100);
            return normalizedValue;
        }
        }
    case 69:
        {
        {
            value = (value < 200 ? 200 : (value > 18000 ? 18000 : value));
            ParameterValue normalizedValue = (value - 200) / (18000 - 200);
            return normalizedValue;
        }
        }
    case 5:
        {
        {
            value = (value < 0.125 ? 0.125 : (value > 8 ? 8 : value));
            ParameterValue normalizedValue = (value - 0.125) / (8 - 0.125);
            return normalizedValue;
        }
        }
    case 70:
        {
        {
            value = (value < 0.5 ? 0.5 : (value > 15 ? 15 : value));
            ParameterValue normalizedValue = (value - 0.5) / (15 - 0.5);
            return normalizedValue;
        }
        }
    case 20:
    case 32:
    case 44:
        {
        {
            value = (value < 0.5 ? 0.5 : (value > 20 ? 20 : value));
            ParameterValue normalizedValue = (value - 0.5) / (20 - 0.5);
            return normalizedValue;
        }
        }
    case 8:
        {
        {
            value = (value < 0.5 ? 0.5 : (value > 24 ? 24 : value));
            ParameterValue normalizedValue = (value - 0.5) / (24 - 0.5);
            return normalizedValue;
        }
        }
    case 65:
        {
        {
            value = (value < 0.5 ? 0.5 : (value > 300 ? 300 : value));
            ParameterValue normalizedValue = (value - 0.5) / (300 - 0.5);
            return normalizedValue;
        }
        }
    case 80:
        {
        {
            value = (value < 0.25 ? 0.25 : (value > 6 ? 6 : value));
            ParameterValue normalizedValue = (value - 0.25) / (6 - 0.25);
            return normalizedValue;
        }
        }
    case 10:
    case 22:
    case 34:
    case 46:
    case 53:
    case 56:
    case 67:
    case 68:
    case 85:
    case 92:
        {
        {
            value = (value < 0.25 ? 0.25 : (value > 8 ? 8 : value));
            ParameterValue normalizedValue = (value - 0.25) / (8 - 0.25);
            return normalizedValue;
        }
        }
    case 76:
        {
        {
            value = (value < 0.25 ? 0.25 : (value > 12 ? 12 : value));
            ParameterValue normalizedValue = (value - 0.25) / (12 - 0.25);
            return normalizedValue;
        }
        }
    case 28:
        {
        {
            value = (value < 0.1 ? 0.1 : (value > 4 ? 4 : value));
            ParameterValue normalizedValue = (value - 0.1) / (4 - 0.1);
            return normalizedValue;
        }
        }
    case 90:
        {
        {
            value = (value < 0.2 ? 0.2 : (value > 1000 ? 1000 : value));
            ParameterValue normalizedValue = (value - 0.2) / (1000 - 0.2);
            return normalizedValue;
        }
        }
    case 91:
        {
        {
            value = (value < -24 ? -24 : (value > 24 ? 24 : value));
            ParameterValue normalizedValue = (value - -24) / (24 - -24);
            return normalizedValue;
        }
        }
    default:
        {
        index -= 96;

        if (index < this->p_01->getNumParameters())
            return this->p_01->convertToNormalizedParameterValue(index, value);

        index -= this->p_01->getNumParameters();

        if (index < this->p_02->getNumParameters())
            return this->p_02->convertToNormalizedParameterValue(index, value);

        index -= this->p_02->getNumParameters();

        if (index < this->p_03->getNumParameters())
            return this->p_03->convertToNormalizedParameterValue(index, value);

        index -= this->p_03->getNumParameters();

        if (index < this->p_04->getNumParameters())
            return this->p_04->convertToNormalizedParameterValue(index, value);

        index -= this->p_04->getNumParameters();

        if (index < this->p_05->getNumParameters())
            return this->p_05->convertToNormalizedParameterValue(index, value);

        index -= this->p_05->getNumParameters();

        if (index < this->p_06->getNumParameters())
            return this->p_06->convertToNormalizedParameterValue(index, value);

        index -= this->p_06->getNumParameters();

        if (index < this->p_07->getNumParameters())
            return this->p_07->convertToNormalizedParameterValue(index, value);

        index -= this->p_07->getNumParameters();

        if (index < this->p_08->getNumParameters())
            return this->p_08->convertToNormalizedParameterValue(index, value);

        return value;
        }
    }
}

ParameterValue convertFromNormalizedParameterValue(ParameterIndex index, ParameterValue value) const {
    value = (value < 0 ? 0 : (value > 1 ? 1 : value));

    switch (index) {
    case 6:
    case 9:
    case 11:
    case 18:
    case 19:
    case 21:
    case 23:
    case 25:
    case 30:
    case 31:
    case 33:
    case 35:
    case 37:
    case 42:
    case 43:
    case 45:
    case 47:
    case 54:
    case 58:
    case 59:
    case 61:
    case 62:
    case 71:
    case 77:
    case 78:
    case 79:
    case 81:
    case 83:
    case 93:
    case 94:
    case 95:
        {
        {
            {
                return 0 + value * (1 - 0);
            }
        }
        }
    case 66:
        {
        {
            {
                return 0 + value * (8 - 0);
            }
        }
        }
    case 50:
        {
        {
            {
                return 0 + value * (10 - 0);
            }
        }
        }
    case 88:
        {
        {
            {
                return 0 + value * (12 - 0);
            }
        }
        }
    case 16:
    case 73:
        {
        {
            {
                return 0 + value * (16 - 0);
            }
        }
        }
    case 4:
        {
        {
            {
                return 0 + value * (32 - 0);
            }
        }
        }
    case 1:
        {
        {
            {
                return 0 + value * (600 - 0);
            }
        }
        }
    case 13:
    case 52:
        {
        {
            {
                return 0 + value * (1200 - 0);
            }
        }
        }
    case 89:
        {
        {
            {
                return 0 + value * (0.95 - 0);
            }
        }
        }
    case 57:
        {
        {
            {
                return 1 + value * (5 - 1);
            }
        }
        }
    case 36:
    case 64:
        {
        {
            {
                return 1 + value * (8 - 1);
            }
        }
        }
    case 39:
        {
        {
            {
                return 1 + value * (200 - 1);
            }
        }
        }
    case 2:
        {
        {
            {
                return 1 + value * (300 - 1);
            }
        }
        }
    case 49:
    case 55:
        {
        {
            {
                return 1 + value * (500 - 1);
            }
        }
        }
    case 63:
        {
        {
            {
                return 1 + value * (2000 - 1);
            }
        }
        }
    case 3:
        {
        {
            {
                return 1 + value * (30000 - 1);
            }
        }
        }
    case 40:
        {
        {
            {
                return 2 + value * (100 - 2);
            }
        }
        }
    case 15:
        {
        {
            {
                return 5 + value * (5000 - 5);
            }
        }
        }
    case 86:
        {
        {
            {
                return 5 + value * (6000 - 5);
            }
        }
        }
    case 14:
    case 26:
    case 27:
    case 38:
        {
        {
            {
                return 5 + value * (10000 - 5);
            }
        }
        }
    case 74:
        {
        {
            {
                return 5 + value * (15000 - 5);
            }
        }
        }
    case 0:
        {
        {
            {
                return 10 + value * (2000 - 10);
            }
        }
        }
    case 51:
        {
        {
            {
                return 10 + value * (6000 - 10);
            }
        }
        }
    case 87:
        {
        {
            {
                return 10 + value * (12000 - 10);
            }
        }
        }
    case 82:
        {
        {
            {
                return 10 + value * (15000 - 10);
            }
        }
        }
    case 84:
        {
        {
            {
                return 12 + value * (96 - 12);
            }
        }
        }
    case 75:
        {
        {
            {
                return 20 + value * (15000 - 20);
            }
        }
        }
    case 7:
        {
        {
            {
                return 25 + value * (400 - 25);
            }
        }
        }
    case 48:
        {
        {
            {
                return 30 + value * (1600 - 30);
            }
        }
        }
    case 12:
        {
        {
            {
                return 40 + value * (1200 - 40);
            }
        }
        }
    case 72:
        {
        {
            {
                return 40 + value * (4000 - 40);
            }
        }
        }
    case 24:
    case 60:
        {
        {
            {
                return 100 + value * (6000 - 100);
            }
        }
        }
    case 17:
    case 29:
    case 41:
        {
        {
            {
                return 100 + value * (18000 - 100);
            }
        }
        }
    case 69:
        {
        {
            {
                return 200 + value * (18000 - 200);
            }
        }
        }
    case 5:
        {
        {
            {
                return 0.125 + value * (8 - 0.125);
            }
        }
        }
    case 70:
        {
        {
            {
                return 0.5 + value * (15 - 0.5);
            }
        }
        }
    case 20:
    case 32:
    case 44:
        {
        {
            {
                return 0.5 + value * (20 - 0.5);
            }
        }
        }
    case 8:
        {
        {
            {
                return 0.5 + value * (24 - 0.5);
            }
        }
        }
    case 65:
        {
        {
            {
                return 0.5 + value * (300 - 0.5);
            }
        }
        }
    case 80:
        {
        {
            {
                return 0.25 + value * (6 - 0.25);
            }
        }
        }
    case 10:
    case 22:
    case 34:
    case 46:
    case 53:
    case 56:
    case 67:
    case 68:
    case 85:
    case 92:
        {
        {
            {
                return 0.25 + value * (8 - 0.25);
            }
        }
        }
    case 76:
        {
        {
            {
                return 0.25 + value * (12 - 0.25);
            }
        }
        }
    case 28:
        {
        {
            {
                return 0.1 + value * (4 - 0.1);
            }
        }
        }
    case 90:
        {
        {
            {
                return 0.2 + value * (1000 - 0.2);
            }
        }
        }
    case 91:
        {
        {
            {
                return -24 + value * (24 - -24);
            }
        }
        }
    default:
        {
        index -= 96;

        if (index < this->p_01->getNumParameters())
            return this->p_01->convertFromNormalizedParameterValue(index, value);

        index -= this->p_01->getNumParameters();

        if (index < this->p_02->getNumParameters())
            return this->p_02->convertFromNormalizedParameterValue(index, value);

        index -= this->p_02->getNumParameters();

        if (index < this->p_03->getNumParameters())
            return this->p_03->convertFromNormalizedParameterValue(index, value);

        index -= this->p_03->getNumParameters();

        if (index < this->p_04->getNumParameters())
            return this->p_04->convertFromNormalizedParameterValue(index, value);

        index -= this->p_04->getNumParameters();

        if (index < this->p_05->getNumParameters())
            return this->p_05->convertFromNormalizedParameterValue(index, value);

        index -= this->p_05->getNumParameters();

        if (index < this->p_06->getNumParameters())
            return this->p_06->convertFromNormalizedParameterValue(index, value);

        index -= this->p_06->getNumParameters();

        if (index < this->p_07->getNumParameters())
            return this->p_07->convertFromNormalizedParameterValue(index, value);

        index -= this->p_07->getNumParameters();

        if (index < this->p_08->getNumParameters())
            return this->p_08->convertFromNormalizedParameterValue(index, value);

        return value;
        }
    }
}

ParameterValue constrainParameterValue(ParameterIndex index, ParameterValue value) const {
    switch (index) {
    case 0:
        {
        return this->param_01_value_constrain(value);
        }
    case 1:
        {
        return this->param_02_value_constrain(value);
        }
    case 2:
        {
        return this->param_03_value_constrain(value);
        }
    case 3:
        {
        return this->param_04_value_constrain(value);
        }
    case 4:
        {
        return this->param_05_value_constrain(value);
        }
    case 5:
        {
        return this->param_06_value_constrain(value);
        }
    case 6:
        {
        return this->param_07_value_constrain(value);
        }
    case 7:
        {
        return this->param_08_value_constrain(value);
        }
    case 8:
        {
        return this->param_09_value_constrain(value);
        }
    case 9:
        {
        return this->param_10_value_constrain(value);
        }
    case 10:
        {
        return this->param_11_value_constrain(value);
        }
    case 11:
        {
        return this->param_12_value_constrain(value);
        }
    case 12:
        {
        return this->param_13_value_constrain(value);
        }
    case 13:
        {
        return this->param_14_value_constrain(value);
        }
    case 14:
        {
        return this->param_15_value_constrain(value);
        }
    case 15:
        {
        return this->param_16_value_constrain(value);
        }
    case 16:
        {
        return this->param_17_value_constrain(value);
        }
    case 17:
        {
        return this->param_18_value_constrain(value);
        }
    case 18:
        {
        return this->param_19_value_constrain(value);
        }
    case 19:
        {
        return this->param_20_value_constrain(value);
        }
    case 20:
        {
        return this->param_21_value_constrain(value);
        }
    case 21:
        {
        return this->param_22_value_constrain(value);
        }
    case 22:
        {
        return this->param_23_value_constrain(value);
        }
    case 23:
        {
        return this->param_24_value_constrain(value);
        }
    case 24:
        {
        return this->param_25_value_constrain(value);
        }
    case 25:
        {
        return this->param_26_value_constrain(value);
        }
    case 26:
        {
        return this->param_27_value_constrain(value);
        }
    case 27:
        {
        return this->param_28_value_constrain(value);
        }
    case 28:
        {
        return this->param_29_value_constrain(value);
        }
    case 29:
        {
        return this->param_30_value_constrain(value);
        }
    case 30:
        {
        return this->param_31_value_constrain(value);
        }
    case 31:
        {
        return this->param_32_value_constrain(value);
        }
    case 32:
        {
        return this->param_33_value_constrain(value);
        }
    case 33:
        {
        return this->param_34_value_constrain(value);
        }
    case 34:
        {
        return this->param_35_value_constrain(value);
        }
    case 35:
        {
        return this->param_36_value_constrain(value);
        }
    case 36:
        {
        return this->param_37_value_constrain(value);
        }
    case 37:
        {
        return this->param_38_value_constrain(value);
        }
    case 38:
        {
        return this->param_39_value_constrain(value);
        }
    case 39:
        {
        return this->param_40_value_constrain(value);
        }
    case 40:
        {
        return this->param_41_value_constrain(value);
        }
    case 41:
        {
        return this->param_42_value_constrain(value);
        }
    case 42:
        {
        return this->param_43_value_constrain(value);
        }
    case 43:
        {
        return this->param_44_value_constrain(value);
        }
    case 44:
        {
        return this->param_45_value_constrain(value);
        }
    case 45:
        {
        return this->param_46_value_constrain(value);
        }
    case 46:
        {
        return this->param_47_value_constrain(value);
        }
    case 47:
        {
        return this->param_48_value_constrain(value);
        }
    case 48:
        {
        return this->param_49_value_constrain(value);
        }
    case 49:
        {
        return this->param_50_value_constrain(value);
        }
    case 50:
        {
        return this->param_51_value_constrain(value);
        }
    case 51:
        {
        return this->param_52_value_constrain(value);
        }
    case 52:
        {
        return this->param_53_value_constrain(value);
        }
    case 53:
        {
        return this->param_54_value_constrain(value);
        }
    case 54:
        {
        return this->param_55_value_constrain(value);
        }
    case 55:
        {
        return this->param_56_value_constrain(value);
        }
    case 56:
        {
        return this->param_57_value_constrain(value);
        }
    case 57:
        {
        return this->param_58_value_constrain(value);
        }
    case 58:
        {
        return this->param_59_value_constrain(value);
        }
    case 59:
        {
        return this->param_60_value_constrain(value);
        }
    case 60:
        {
        return this->param_61_value_constrain(value);
        }
    case 61:
        {
        return this->param_62_value_constrain(value);
        }
    case 62:
        {
        return this->param_63_value_constrain(value);
        }
    case 63:
        {
        return this->param_64_value_constrain(value);
        }
    case 64:
        {
        return this->param_65_value_constrain(value);
        }
    case 65:
        {
        return this->param_66_value_constrain(value);
        }
    case 66:
        {
        return this->param_67_value_constrain(value);
        }
    case 67:
        {
        return this->param_68_value_constrain(value);
        }
    case 68:
        {
        return this->param_69_value_constrain(value);
        }
    case 69:
        {
        return this->param_70_value_constrain(value);
        }
    case 70:
        {
        return this->param_71_value_constrain(value);
        }
    case 71:
        {
        return this->param_72_value_constrain(value);
        }
    case 72:
        {
        return this->param_73_value_constrain(value);
        }
    case 73:
        {
        return this->param_74_value_constrain(value);
        }
    case 74:
        {
        return this->param_75_value_constrain(value);
        }
    case 75:
        {
        return this->param_76_value_constrain(value);
        }
    case 76:
        {
        return this->param_77_value_constrain(value);
        }
    case 77:
        {
        return this->param_78_value_constrain(value);
        }
    case 78:
        {
        return this->param_79_value_constrain(value);
        }
    case 79:
        {
        return this->param_80_value_constrain(value);
        }
    case 80:
        {
        return this->param_81_value_constrain(value);
        }
    case 81:
        {
        return this->param_82_value_constrain(value);
        }
    case 82:
        {
        return this->param_83_value_constrain(value);
        }
    case 83:
        {
        return this->param_84_value_constrain(value);
        }
    case 84:
        {
        return this->param_85_value_constrain(value);
        }
    case 85:
        {
        return this->param_86_value_constrain(value);
        }
    case 86:
        {
        return this->param_87_value_constrain(value);
        }
    case 87:
        {
        return this->param_88_value_constrain(value);
        }
    case 88:
        {
        return this->param_89_value_constrain(value);
        }
    case 89:
        {
        return this->param_90_value_constrain(value);
        }
    case 90:
        {
        return this->param_91_value_constrain(value);
        }
    case 91:
        {
        return this->param_92_value_constrain(value);
        }
    case 92:
        {
        return this->param_93_value_constrain(value);
        }
    case 93:
        {
        return this->param_94_value_constrain(value);
        }
    case 94:
        {
        return this->param_95_value_constrain(value);
        }
    case 95:
        {
        return this->param_96_value_constrain(value);
        }
    default:
        {
        index -= 96;

        if (index < this->p_01->getNumParameters())
            return this->p_01->constrainParameterValue(index, value);

        index -= this->p_01->getNumParameters();

        if (index < this->p_02->getNumParameters())
            return this->p_02->constrainParameterValue(index, value);

        index -= this->p_02->getNumParameters();

        if (index < this->p_03->getNumParameters())
            return this->p_03->constrainParameterValue(index, value);

        index -= this->p_03->getNumParameters();

        if (index < this->p_04->getNumParameters())
            return this->p_04->constrainParameterValue(index, value);

        index -= this->p_04->getNumParameters();

        if (index < this->p_05->getNumParameters())
            return this->p_05->constrainParameterValue(index, value);

        index -= this->p_05->getNumParameters();

        if (index < this->p_06->getNumParameters())
            return this->p_06->constrainParameterValue(index, value);

        index -= this->p_06->getNumParameters();

        if (index < this->p_07->getNumParameters())
            return this->p_07->constrainParameterValue(index, value);

        index -= this->p_07->getNumParameters();

        if (index < this->p_08->getNumParameters())
            return this->p_08->constrainParameterValue(index, value);

        return value;
        }
    }
}

void processNumMessage(MessageTag tag, MessageTag objectId, MillisecondTime time, number payload) {
    RNBO_UNUSED(objectId);
    this->updateTime(time, (ENGINE*)nullptr);

    switch (tag) {
    case TAG("hit_kick"):
        {
        this->inport_01_value_number_set(payload);
        break;
        }
    case TAG("hit_snare"):
        {
        this->inport_02_value_number_set(payload);
        break;
        }
    case TAG("hit_hat"):
        {
        this->inport_03_value_number_set(payload);
        break;
        }
    case TAG("hit_clap"):
        {
        this->inport_04_value_number_set(payload);
        break;
        }
    case TAG("hit_tom"):
        {
        this->inport_05_value_number_set(payload);
        break;
        }
    case TAG("hit_rim"):
        {
        this->inport_06_value_number_set(payload);
        break;
        }
    case TAG("hit_bell"):
        {
        this->inport_07_value_number_set(payload);
        break;
        }
    case TAG("hit_bass"):
        {
        this->inport_08_value_number_set(payload);
        break;
        }
    }

    this->p_01->processNumMessage(tag, objectId, time, payload);
    this->p_02->processNumMessage(tag, objectId, time, payload);
    this->p_03->processNumMessage(tag, objectId, time, payload);
    this->p_04->processNumMessage(tag, objectId, time, payload);
    this->p_05->processNumMessage(tag, objectId, time, payload);
    this->p_06->processNumMessage(tag, objectId, time, payload);
    this->p_07->processNumMessage(tag, objectId, time, payload);
    this->p_08->processNumMessage(tag, objectId, time, payload);
}

void processListMessage(
    MessageTag tag,
    MessageTag objectId,
    MillisecondTime time,
    const list& payload
) {
    RNBO_UNUSED(objectId);
    this->updateTime(time, (ENGINE*)nullptr);

    switch (tag) {
    case TAG("hit_kick"):
        {
        this->inport_01_value_list_set(payload);
        break;
        }
    case TAG("hit_snare"):
        {
        this->inport_02_value_list_set(payload);
        break;
        }
    case TAG("hit_hat"):
        {
        this->inport_03_value_list_set(payload);
        break;
        }
    case TAG("hit_clap"):
        {
        this->inport_04_value_list_set(payload);
        break;
        }
    case TAG("hit_tom"):
        {
        this->inport_05_value_list_set(payload);
        break;
        }
    case TAG("hit_rim"):
        {
        this->inport_06_value_list_set(payload);
        break;
        }
    case TAG("hit_bell"):
        {
        this->inport_07_value_list_set(payload);
        break;
        }
    case TAG("hit_bass"):
        {
        this->inport_08_value_list_set(payload);
        break;
        }
    }

    this->p_01->processListMessage(tag, objectId, time, payload);
    this->p_02->processListMessage(tag, objectId, time, payload);
    this->p_03->processListMessage(tag, objectId, time, payload);
    this->p_04->processListMessage(tag, objectId, time, payload);
    this->p_05->processListMessage(tag, objectId, time, payload);
    this->p_06->processListMessage(tag, objectId, time, payload);
    this->p_07->processListMessage(tag, objectId, time, payload);
    this->p_08->processListMessage(tag, objectId, time, payload);
}

void processBangMessage(MessageTag tag, MessageTag objectId, MillisecondTime time) {
    RNBO_UNUSED(objectId);
    this->updateTime(time, (ENGINE*)nullptr);

    switch (tag) {
    case TAG("hit_kick"):
        {
        this->inport_01_value_bang_bang();
        break;
        }
    case TAG("hit_snare"):
        {
        this->inport_02_value_bang_bang();
        break;
        }
    case TAG("hit_hat"):
        {
        this->inport_03_value_bang_bang();
        break;
        }
    case TAG("hit_clap"):
        {
        this->inport_04_value_bang_bang();
        break;
        }
    case TAG("hit_tom"):
        {
        this->inport_05_value_bang_bang();
        break;
        }
    case TAG("hit_rim"):
        {
        this->inport_06_value_bang_bang();
        break;
        }
    case TAG("hit_bell"):
        {
        this->inport_07_value_bang_bang();
        break;
        }
    case TAG("hit_bass"):
        {
        this->inport_08_value_bang_bang();
        break;
        }
    }

    this->p_01->processBangMessage(tag, objectId, time);
    this->p_02->processBangMessage(tag, objectId, time);
    this->p_03->processBangMessage(tag, objectId, time);
    this->p_04->processBangMessage(tag, objectId, time);
    this->p_05->processBangMessage(tag, objectId, time);
    this->p_06->processBangMessage(tag, objectId, time);
    this->p_07->processBangMessage(tag, objectId, time);
    this->p_08->processBangMessage(tag, objectId, time);
}

MessageTagInfo resolveTag(MessageTag tag) const {
    switch (tag) {
    case TAG("hit_kick"):
        {
        return "hit_kick";
        }
    case TAG(""):
        {
        return "";
        }
    case TAG("hit_snare"):
        {
        return "hit_snare";
        }
    case TAG("hit_hat"):
        {
        return "hit_hat";
        }
    case TAG("hit_clap"):
        {
        return "hit_clap";
        }
    case TAG("hit_tom"):
        {
        return "hit_tom";
        }
    case TAG("hit_rim"):
        {
        return "hit_rim";
        }
    case TAG("hit_bell"):
        {
        return "hit_bell";
        }
    case TAG("hit_bass"):
        {
        return "hit_bass";
        }
    }

    auto subpatchResult_0 = this->p_01->resolveTag(tag);

    if (subpatchResult_0)
        return subpatchResult_0;

    auto subpatchResult_1 = this->p_02->resolveTag(tag);

    if (subpatchResult_1)
        return subpatchResult_1;

    auto subpatchResult_2 = this->p_03->resolveTag(tag);

    if (subpatchResult_2)
        return subpatchResult_2;

    auto subpatchResult_3 = this->p_04->resolveTag(tag);

    if (subpatchResult_3)
        return subpatchResult_3;

    auto subpatchResult_4 = this->p_05->resolveTag(tag);

    if (subpatchResult_4)
        return subpatchResult_4;

    auto subpatchResult_5 = this->p_06->resolveTag(tag);

    if (subpatchResult_5)
        return subpatchResult_5;

    auto subpatchResult_6 = this->p_07->resolveTag(tag);

    if (subpatchResult_6)
        return subpatchResult_6;

    auto subpatchResult_7 = this->p_08->resolveTag(tag);

    if (subpatchResult_7)
        return subpatchResult_7;

    return "";
}

MessageIndex getNumMessages() const {
    return 8;
}

const MessageInfo& getMessageInfo(MessageIndex index) const {
    switch (index) {
    case 0:
        {
        static const MessageInfo r0 = {
            "hit_kick",
            Inport
        };

        return r0;
        }
    case 1:
        {
        static const MessageInfo r1 = {
            "hit_snare",
            Inport
        };

        return r1;
        }
    case 2:
        {
        static const MessageInfo r2 = {
            "hit_hat",
            Inport
        };

        return r2;
        }
    case 3:
        {
        static const MessageInfo r3 = {
            "hit_clap",
            Inport
        };

        return r3;
        }
    case 4:
        {
        static const MessageInfo r4 = {
            "hit_tom",
            Inport
        };

        return r4;
        }
    case 5:
        {
        static const MessageInfo r5 = {
            "hit_rim",
            Inport
        };

        return r5;
        }
    case 6:
        {
        static const MessageInfo r6 = {
            "hit_bell",
            Inport
        };

        return r6;
        }
    case 7:
        {
        static const MessageInfo r7 = {
            "hit_bass",
            Inport
        };

        return r7;
        }
    }

    return NullMessageInfo;
}

protected:

class RNBOSubpatcher_118 : public PatcherInterfaceImpl {
    
    friend class rnbomatic;
    
    public:
    
    RNBOSubpatcher_118()
    {}
    
    ~RNBOSubpatcher_118()
    {
        deallocateSignals();
    }
    
    Index getNumMidiInputPorts() const {
        return 0;
    }
    
    void processMidiEvent(MillisecondTime , int , ConstByteArray , Index ) {}
    
    Index getNumMidiOutputPorts() const {
        return 0;
    }
    
    void process(
        const SampleValue * const* inputs,
        Index numInputs,
        SampleValue * const* outputs,
        Index numOutputs,
        Index n
    ) {
        RNBO_UNUSED(numInputs);
        RNBO_UNUSED(inputs);
        this->vs = n;
        this->updateTime(this->getEngine()->getCurrentTime(), (ENGINE*)nullptr, true);
        SampleValue * out1 = (numOutputs >= 1 && outputs[0] ? outputs[0] : this->dummyBuffer);
        SampleValue * out2 = (numOutputs >= 2 && outputs[1] ? outputs[1] : this->dummyBuffer);
        this->click_01_perform(this->signals[0], n);
        this->ip_01_perform(this->signals[1], n);
        this->ip_02_perform(this->signals[2], n);
        this->ip_03_perform(this->signals[3], n);
        this->ip_04_perform(this->signals[4], n);
        this->ip_05_perform(this->signals[5], n);
        this->ip_06_perform(this->signals[6], n);
        this->ip_07_perform(this->signals[7], n);
        this->ip_08_perform(this->signals[8], n);
        this->ip_09_perform(this->signals[9], n);
        this->ip_10_perform(this->signals[10], n);
        this->ip_11_perform(this->signals[11], n);
        this->ip_12_perform(this->signals[12], n);
    
        this->codebox_tilde_01_perform(
            this->signals[0],
            this->signals[1],
            this->signals[2],
            this->signals[3],
            this->signals[4],
            this->signals[5],
            this->signals[6],
            this->signals[7],
            this->signals[8],
            this->signals[9],
            this->signals[10],
            this->signals[11],
            this->signals[12],
            this->signals[13],
            n
        );
    
        this->dspexpr_01_perform(this->signals[13], this->dspexpr_01_in2, this->signals[12], n);
        this->signalforwarder_01_perform(this->signals[12], out2, n);
        this->signalforwarder_02_perform(this->signals[12], out1, n);
        this->stackprotect_perform(n);
        this->audioProcessSampleCount += this->vs;
    }
    
    void prepareToProcess(number sampleRate, Index maxBlockSize, bool force) {
        RNBO_ASSERT(this->_isInitialized);
    
        if (this->maxvs < maxBlockSize || !this->didAllocateSignals) {
            Index i;
    
            for (i = 0; i < 14; i++) {
                this->signals[i] = resizeSignal(this->signals[i], this->maxvs, maxBlockSize);
            }
    
            this->click_01_buf = resizeSignal(this->click_01_buf, this->maxvs, maxBlockSize);
            this->ip_01_sigbuf = resizeSignal(this->ip_01_sigbuf, this->maxvs, maxBlockSize);
            this->ip_02_sigbuf = resizeSignal(this->ip_02_sigbuf, this->maxvs, maxBlockSize);
            this->ip_03_sigbuf = resizeSignal(this->ip_03_sigbuf, this->maxvs, maxBlockSize);
            this->ip_04_sigbuf = resizeSignal(this->ip_04_sigbuf, this->maxvs, maxBlockSize);
            this->ip_05_sigbuf = resizeSignal(this->ip_05_sigbuf, this->maxvs, maxBlockSize);
            this->ip_06_sigbuf = resizeSignal(this->ip_06_sigbuf, this->maxvs, maxBlockSize);
            this->ip_07_sigbuf = resizeSignal(this->ip_07_sigbuf, this->maxvs, maxBlockSize);
            this->ip_08_sigbuf = resizeSignal(this->ip_08_sigbuf, this->maxvs, maxBlockSize);
            this->ip_09_sigbuf = resizeSignal(this->ip_09_sigbuf, this->maxvs, maxBlockSize);
            this->ip_10_sigbuf = resizeSignal(this->ip_10_sigbuf, this->maxvs, maxBlockSize);
            this->ip_11_sigbuf = resizeSignal(this->ip_11_sigbuf, this->maxvs, maxBlockSize);
            this->ip_12_sigbuf = resizeSignal(this->ip_12_sigbuf, this->maxvs, maxBlockSize);
            this->zeroBuffer = resizeSignal(this->zeroBuffer, this->maxvs, maxBlockSize);
            this->dummyBuffer = resizeSignal(this->dummyBuffer, this->maxvs, maxBlockSize);
            this->didAllocateSignals = true;
        }
    
        const bool sampleRateChanged = sampleRate != this->sr;
        const bool maxvsChanged = maxBlockSize != this->maxvs;
        const bool forceDSPSetup = sampleRateChanged || maxvsChanged || force;
    
        if (sampleRateChanged || maxvsChanged) {
            this->vs = maxBlockSize;
            this->maxvs = maxBlockSize;
            this->sr = sampleRate;
            this->invsr = 1 / sampleRate;
        }
    
        this->ip_01_dspsetup(forceDSPSetup);
        this->ip_02_dspsetup(forceDSPSetup);
        this->ip_03_dspsetup(forceDSPSetup);
        this->ip_04_dspsetup(forceDSPSetup);
        this->ip_05_dspsetup(forceDSPSetup);
        this->ip_06_dspsetup(forceDSPSetup);
        this->ip_07_dspsetup(forceDSPSetup);
        this->ip_08_dspsetup(forceDSPSetup);
        this->ip_09_dspsetup(forceDSPSetup);
        this->ip_10_dspsetup(forceDSPSetup);
        this->ip_11_dspsetup(forceDSPSetup);
        this->ip_12_dspsetup(forceDSPSetup);
    
        if (sampleRateChanged)
            this->onSampleRateChanged(sampleRate);
    }
    
    number msToSamps(MillisecondTime ms, number sampleRate) {
        return ms * sampleRate * 0.001;
    }
    
    MillisecondTime sampsToMs(SampleIndex samps) {
        return samps * (this->invsr * 1000);
    }
    
    Index getNumInputChannels() const {
        return 0;
    }
    
    Index getNumOutputChannels() const {
        return 2;
    }
    
    void getPreset(PatcherStateInterface& ) {}
    
    void setPreset(MillisecondTime , PatcherStateInterface& ) {}
    
    void setParameterValue(ParameterIndex , ParameterValue , MillisecondTime ) {}
    
    void processParameterEvent(ParameterIndex index, ParameterValue value, MillisecondTime time) {
        this->setParameterValue(index, value, time);
    }
    
    void processParameterBangEvent(ParameterIndex index, MillisecondTime time) {
        this->setParameterValue(index, this->getParameterValue(index), time);
    }
    
    void processNormalizedParameterEvent(ParameterIndex index, ParameterValue value, MillisecondTime time) {
        this->setParameterValueNormalized(index, value, time);
    }
    
    ParameterValue getParameterValue(ParameterIndex index)  {
        switch (index) {
        default:
            {
            return 0;
            }
        }
    }
    
    ParameterIndex getNumSignalInParameters() const {
        return 0;
    }
    
    ParameterIndex getNumSignalOutParameters() const {
        return 0;
    }
    
    ParameterIndex getNumParameters() const {
        return 0;
    }
    
    ConstCharPointer getParameterName(ParameterIndex index) const {
        switch (index) {
        default:
            {
            return "bogus";
            }
        }
    }
    
    ConstCharPointer getParameterId(ParameterIndex index) const {
        switch (index) {
        default:
            {
            return "bogus";
            }
        }
    }
    
    void getParameterInfo(ParameterIndex , ParameterInfo * ) const {}
    
    ParameterValue applyStepsToNormalizedParameterValue(ParameterValue normalizedValue, int steps) const {
        if (steps == 1) {
            if (normalizedValue > 0) {
                normalizedValue = 1.;
            }
        } else {
            ParameterValue oneStep = (number)1. / (steps - 1);
            ParameterValue numberOfSteps = rnbo_fround(normalizedValue / oneStep * 1 / (number)1) * (number)1;
            normalizedValue = numberOfSteps * oneStep;
        }
    
        return normalizedValue;
    }
    
    ParameterValue convertToNormalizedParameterValue(ParameterIndex index, ParameterValue value) const {
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    ParameterValue convertFromNormalizedParameterValue(ParameterIndex index, ParameterValue value) const {
        value = (value < 0 ? 0 : (value > 1 ? 1 : value));
    
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    ParameterValue constrainParameterValue(ParameterIndex index, ParameterValue value) const {
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    void processNumMessage(MessageTag , MessageTag , MillisecondTime , number ) {}
    
    void processListMessage(MessageTag , MessageTag , MillisecondTime , const list& ) {}
    
    void processBangMessage(MessageTag , MessageTag , MillisecondTime ) {}
    
    MessageTagInfo resolveTag(MessageTag tag) const {
        switch (tag) {
    
        }
    
        return nullptr;
    }
    
    DataRef* getDataRef(DataRefIndex index)  {
        switch (index) {
        default:
            {
            return nullptr;
            }
        }
    }
    
    DataRefIndex getNumDataRefs() const {
        return 0;
    }
    
    void processDataViewUpdate(DataRefIndex , MillisecondTime ) {}
    
    void initialize() {
        RNBO_ASSERT(!this->_isInitialized);
        this->assign_defaults();
        this->applyState();
        this->_isInitialized = true;
    }
    
    protected:
    
    void updateTime(MillisecondTime time, INTERNALENGINE*, bool inProcess = false) {
    	if (time == TimeNow) time = getTopLevelPatcher()->getPatcherTime();
    	getTopLevelPatcher()->processInternalEvents(time);
    	updateTime(time, (EXTERNALENGINE*)nullptr);
    }
    
    RNBOSubpatcher_118* operator->() {
        return this;
    }
    const RNBOSubpatcher_118* operator->() const {
        return this;
    }
    virtual rnbomatic* getPatcher() const {
        return static_cast<rnbomatic *>(_parentPatcher);
    }
    
    rnbomatic* getTopLevelPatcher() {
        return this->getPatcher()->getTopLevelPatcher();
    }
    
    void cancelClockEvents()
    {
    }
    
    number maximum(number x, number y) {
        return (x < y ? y : x);
    }
    
    number wrap(number x, number low, number high) {
        number lo;
        number hi;
    
        if (low == high)
            return low;
    
        if (low > high) {
            hi = low;
            lo = high;
        } else {
            lo = low;
            hi = high;
        }
    
        number range = hi - lo;
    
        if (x >= lo && x < hi)
            return x;
    
        if (range <= 0.000000001)
            return lo;
    
        Int numWraps = (Int)(trunc((x - lo) / range));
        numWraps = numWraps - ((x < lo ? 1 : 0));
        number result = x - range * numWraps;
    
        if (result >= hi)
            return result - range;
        else
            return result;
    }
    
    MillisecondTime getPatcherTime() const {
        return this->_currentTime;
    }
    
    void eventinlet_02_out1_bang_bang() {
        this->ip_01_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_02_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_01_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_01_value_set(converted);
        }
    }
    
    void eventinlet_03_out1_bang_bang() {
        this->ip_02_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_03_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_02_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_02_value_set(converted);
        }
    }
    
    void eventinlet_04_out1_bang_bang() {
        this->ip_03_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_04_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_03_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_03_value_set(converted);
        }
    }
    
    void eventinlet_05_out1_bang_bang() {
        this->ip_04_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_05_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_04_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_04_value_set(converted);
        }
    }
    
    void eventinlet_06_out1_bang_bang() {
        this->ip_05_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_06_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_05_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_05_value_set(converted);
        }
    }
    
    void eventinlet_07_out1_bang_bang() {
        this->ip_06_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_07_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_06_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_06_value_set(converted);
        }
    }
    
    void eventinlet_08_out1_bang_bang() {
        this->ip_07_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_08_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_07_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_07_value_set(converted);
        }
    }
    
    void eventinlet_09_out1_bang_bang() {
        this->ip_08_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_09_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_08_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_08_value_set(converted);
        }
    }
    
    void eventinlet_10_out1_bang_bang() {
        this->ip_09_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_10_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_09_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_09_value_set(converted);
        }
    }
    
    void eventinlet_11_out1_bang_bang() {
        this->ip_10_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_11_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_10_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_10_value_set(converted);
        }
    }
    
    void eventinlet_12_out1_bang_bang() {
        this->ip_11_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_12_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_11_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_11_value_set(converted);
        }
    }
    
    void eventinlet_13_out1_bang_bang() {
        this->ip_12_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_13_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_12_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_12_value_set(converted);
        }
    }
    
    void deallocateSignals() {
        Index i;
    
        for (i = 0; i < 14; i++) {
            this->signals[i] = freeSignal(this->signals[i]);
        }
    
        this->click_01_buf = freeSignal(this->click_01_buf);
        this->ip_01_sigbuf = freeSignal(this->ip_01_sigbuf);
        this->ip_02_sigbuf = freeSignal(this->ip_02_sigbuf);
        this->ip_03_sigbuf = freeSignal(this->ip_03_sigbuf);
        this->ip_04_sigbuf = freeSignal(this->ip_04_sigbuf);
        this->ip_05_sigbuf = freeSignal(this->ip_05_sigbuf);
        this->ip_06_sigbuf = freeSignal(this->ip_06_sigbuf);
        this->ip_07_sigbuf = freeSignal(this->ip_07_sigbuf);
        this->ip_08_sigbuf = freeSignal(this->ip_08_sigbuf);
        this->ip_09_sigbuf = freeSignal(this->ip_09_sigbuf);
        this->ip_10_sigbuf = freeSignal(this->ip_10_sigbuf);
        this->ip_11_sigbuf = freeSignal(this->ip_11_sigbuf);
        this->ip_12_sigbuf = freeSignal(this->ip_12_sigbuf);
        this->zeroBuffer = freeSignal(this->zeroBuffer);
        this->dummyBuffer = freeSignal(this->dummyBuffer);
    }
    
    Index getMaxBlockSize() const {
        return this->maxvs;
    }
    
    number getSampleRate() const {
        return this->sr;
    }
    
    bool hasFixedVectorSize() const {
        return false;
    }
    
    void setProbingTarget(MessageTag ) {}
    
    void initializeObjects() {
        this->ip_01_init();
        this->ip_02_init();
        this->ip_03_init();
        this->ip_04_init();
        this->ip_05_init();
        this->ip_06_init();
        this->ip_07_init();
        this->ip_08_init();
        this->ip_09_init();
        this->ip_10_init();
        this->ip_11_init();
        this->ip_12_init();
    }
    
    Index getIsMuted()  {
        return this->isMuted;
    }
    
    void setIsMuted(Index v)  {
        this->isMuted = v;
    }
    
    void onSampleRateChanged(double ) {}
    
    void extractState(PatcherStateInterface& ) {}
    
    void applyState() {}
    
    void setParameterOffset(ParameterIndex offset) {
        this->parameterOffset = offset;
    }
    
    void processClockEvent(MillisecondTime , ClockId , bool , ParameterValue ) {}
    
    void processOutletAtCurrentTime(EngineLink* , OutletIndex , ParameterValue ) {}
    
    void processOutletEvent(
        EngineLink* sender,
        OutletIndex index,
        ParameterValue value,
        MillisecondTime time
    ) {
        this->updateTime(time, (ENGINE*)nullptr);
        this->processOutletAtCurrentTime(sender, index, value);
    }
    
    void sendOutlet(OutletIndex index, ParameterValue value) {
        this->getEngine()->sendOutlet(this, index, value);
    }
    
    void startup() {}
    
    void fillDataRef(DataRefIndex , DataRef& ) {}
    
    void allocateDataRefs() {}
    
    void ip_01_value_set(number v) {
        this->ip_01_value = v;
        this->ip_01_fillSigBuf();
        this->ip_01_lastValue = v;
    }
    
    void eventinlet_02_out1_number_set(number v) {
        this->ip_01_value_set(v);
    }
    
    void ip_02_value_set(number v) {
        this->ip_02_value = v;
        this->ip_02_fillSigBuf();
        this->ip_02_lastValue = v;
    }
    
    void eventinlet_03_out1_number_set(number v) {
        this->ip_02_value_set(v);
    }
    
    void ip_03_value_set(number v) {
        this->ip_03_value = v;
        this->ip_03_fillSigBuf();
        this->ip_03_lastValue = v;
    }
    
    void eventinlet_04_out1_number_set(number v) {
        this->ip_03_value_set(v);
    }
    
    void ip_04_value_set(number v) {
        this->ip_04_value = v;
        this->ip_04_fillSigBuf();
        this->ip_04_lastValue = v;
    }
    
    void eventinlet_05_out1_number_set(number v) {
        this->ip_04_value_set(v);
    }
    
    void ip_05_value_set(number v) {
        this->ip_05_value = v;
        this->ip_05_fillSigBuf();
        this->ip_05_lastValue = v;
    }
    
    void eventinlet_06_out1_number_set(number v) {
        this->ip_05_value_set(v);
    }
    
    void ip_06_value_set(number v) {
        this->ip_06_value = v;
        this->ip_06_fillSigBuf();
        this->ip_06_lastValue = v;
    }
    
    void eventinlet_07_out1_number_set(number v) {
        this->ip_06_value_set(v);
    }
    
    void ip_07_value_set(number v) {
        this->ip_07_value = v;
        this->ip_07_fillSigBuf();
        this->ip_07_lastValue = v;
    }
    
    void eventinlet_08_out1_number_set(number v) {
        this->ip_07_value_set(v);
    }
    
    void ip_08_value_set(number v) {
        this->ip_08_value = v;
        this->ip_08_fillSigBuf();
        this->ip_08_lastValue = v;
    }
    
    void eventinlet_09_out1_number_set(number v) {
        this->ip_08_value_set(v);
    }
    
    void ip_09_value_set(number v) {
        this->ip_09_value = v;
        this->ip_09_fillSigBuf();
        this->ip_09_lastValue = v;
    }
    
    void eventinlet_10_out1_number_set(number v) {
        this->ip_09_value_set(v);
    }
    
    void ip_10_value_set(number v) {
        this->ip_10_value = v;
        this->ip_10_fillSigBuf();
        this->ip_10_lastValue = v;
    }
    
    void eventinlet_11_out1_number_set(number v) {
        this->ip_10_value_set(v);
    }
    
    void ip_11_value_set(number v) {
        this->ip_11_value = v;
        this->ip_11_fillSigBuf();
        this->ip_11_lastValue = v;
    }
    
    void eventinlet_12_out1_number_set(number v) {
        this->ip_11_value_set(v);
    }
    
    void ip_12_value_set(number v) {
        this->ip_12_value = v;
        this->ip_12_fillSigBuf();
        this->ip_12_lastValue = v;
    }
    
    void eventinlet_13_out1_number_set(number v) {
        this->ip_12_value_set(v);
    }
    
    void click_01_click_number_set(number v) {
        for (SampleIndex i = (SampleIndex)(this->click_01_lastclick + 1); i < this->sampleOffsetIntoNextAudioBuffer; i++) {
            this->click_01_buf[(Index)i] = 0;
        }
    
        this->click_01_lastclick = this->sampleOffsetIntoNextAudioBuffer;
        this->click_01_buf[(Index)this->click_01_lastclick] = v;
    }
    
    void click_01_click_bang_bang() {
        this->click_01_click_number_set(1);
    }
    
    void eventinlet_01_out1_bang_bang() {
        this->click_01_click_bang_bang();
    }
    
    void eventinlet_01_out1_number_set(number v) {
        this->click_01_click_number_set(v);
    }
    
    template<typename LISTTYPE> void eventinlet_01_out1_list_set(const LISTTYPE& v) {
        {
            number converted = (v->length > 0 ? v[0] : 0);
            this->click_01_click_number_set(converted);
        }
    }
    
    void ip_01_value_bang() {
        number v = this->ip_01_value;
        this->ip_01_fillSigBuf();
        this->ip_01_lastValue = v;
    }
    
    void ip_01_impulse_set(number v) {
        this->ip_01_impulse = v;
        this->ip_01_fillSigBuf();
        this->ip_01_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_01_resetCount = lengthInSamples;
    }
    
    void ip_02_value_bang() {
        number v = this->ip_02_value;
        this->ip_02_fillSigBuf();
        this->ip_02_lastValue = v;
    }
    
    void ip_02_impulse_set(number v) {
        this->ip_02_impulse = v;
        this->ip_02_fillSigBuf();
        this->ip_02_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_02_resetCount = lengthInSamples;
    }
    
    void ip_03_value_bang() {
        number v = this->ip_03_value;
        this->ip_03_fillSigBuf();
        this->ip_03_lastValue = v;
    }
    
    void ip_03_impulse_set(number v) {
        this->ip_03_impulse = v;
        this->ip_03_fillSigBuf();
        this->ip_03_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_03_resetCount = lengthInSamples;
    }
    
    void ip_04_value_bang() {
        number v = this->ip_04_value;
        this->ip_04_fillSigBuf();
        this->ip_04_lastValue = v;
    }
    
    void ip_04_impulse_set(number v) {
        this->ip_04_impulse = v;
        this->ip_04_fillSigBuf();
        this->ip_04_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_04_resetCount = lengthInSamples;
    }
    
    void ip_05_value_bang() {
        number v = this->ip_05_value;
        this->ip_05_fillSigBuf();
        this->ip_05_lastValue = v;
    }
    
    void ip_05_impulse_set(number v) {
        this->ip_05_impulse = v;
        this->ip_05_fillSigBuf();
        this->ip_05_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_05_resetCount = lengthInSamples;
    }
    
    void ip_06_value_bang() {
        number v = this->ip_06_value;
        this->ip_06_fillSigBuf();
        this->ip_06_lastValue = v;
    }
    
    void ip_06_impulse_set(number v) {
        this->ip_06_impulse = v;
        this->ip_06_fillSigBuf();
        this->ip_06_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_06_resetCount = lengthInSamples;
    }
    
    void ip_07_value_bang() {
        number v = this->ip_07_value;
        this->ip_07_fillSigBuf();
        this->ip_07_lastValue = v;
    }
    
    void ip_07_impulse_set(number v) {
        this->ip_07_impulse = v;
        this->ip_07_fillSigBuf();
        this->ip_07_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_07_resetCount = lengthInSamples;
    }
    
    void ip_08_value_bang() {
        number v = this->ip_08_value;
        this->ip_08_fillSigBuf();
        this->ip_08_lastValue = v;
    }
    
    void ip_08_impulse_set(number v) {
        this->ip_08_impulse = v;
        this->ip_08_fillSigBuf();
        this->ip_08_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_08_resetCount = lengthInSamples;
    }
    
    void ip_09_value_bang() {
        number v = this->ip_09_value;
        this->ip_09_fillSigBuf();
        this->ip_09_lastValue = v;
    }
    
    void ip_09_impulse_set(number v) {
        this->ip_09_impulse = v;
        this->ip_09_fillSigBuf();
        this->ip_09_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_09_resetCount = lengthInSamples;
    }
    
    void ip_10_value_bang() {
        number v = this->ip_10_value;
        this->ip_10_fillSigBuf();
        this->ip_10_lastValue = v;
    }
    
    void ip_10_impulse_set(number v) {
        this->ip_10_impulse = v;
        this->ip_10_fillSigBuf();
        this->ip_10_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_10_resetCount = lengthInSamples;
    }
    
    void ip_11_value_bang() {
        number v = this->ip_11_value;
        this->ip_11_fillSigBuf();
        this->ip_11_lastValue = v;
    }
    
    void ip_11_impulse_set(number v) {
        this->ip_11_impulse = v;
        this->ip_11_fillSigBuf();
        this->ip_11_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_11_resetCount = lengthInSamples;
    }
    
    void ip_12_value_bang() {
        number v = this->ip_12_value;
        this->ip_12_fillSigBuf();
        this->ip_12_lastValue = v;
    }
    
    void ip_12_impulse_set(number v) {
        this->ip_12_impulse = v;
        this->ip_12_fillSigBuf();
        this->ip_12_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_12_resetCount = lengthInSamples;
    }
    
    void click_01_perform(SampleValue * out, Index n) {
        auto __click_01_lastclick = this->click_01_lastclick;
    
        for (SampleIndex i = 0; i <= __click_01_lastclick; i++) {
            out[(Index)i] = this->click_01_buf[(Index)i];
        }
    
        for (SampleIndex i = (SampleIndex)(__click_01_lastclick + 1); i < (SampleIndex)(n); i++) {
            out[(Index)i] = 0;
        }
    
        __click_01_lastclick = -1;
        this->click_01_lastclick = __click_01_lastclick;
    }
    
    void ip_01_perform(SampleValue * out, Index n) {
        auto __ip_01_lastValue = this->ip_01_lastValue;
        auto __ip_01_lastIndex = this->ip_01_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_01_lastIndex ? __ip_01_lastValue : this->ip_01_sigbuf[(Index)i]);
        }
    
        __ip_01_lastIndex = 0;
        this->ip_01_lastIndex = __ip_01_lastIndex;
    }
    
    void ip_02_perform(SampleValue * out, Index n) {
        auto __ip_02_lastValue = this->ip_02_lastValue;
        auto __ip_02_lastIndex = this->ip_02_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_02_lastIndex ? __ip_02_lastValue : this->ip_02_sigbuf[(Index)i]);
        }
    
        __ip_02_lastIndex = 0;
        this->ip_02_lastIndex = __ip_02_lastIndex;
    }
    
    void ip_03_perform(SampleValue * out, Index n) {
        auto __ip_03_lastValue = this->ip_03_lastValue;
        auto __ip_03_lastIndex = this->ip_03_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_03_lastIndex ? __ip_03_lastValue : this->ip_03_sigbuf[(Index)i]);
        }
    
        __ip_03_lastIndex = 0;
        this->ip_03_lastIndex = __ip_03_lastIndex;
    }
    
    void ip_04_perform(SampleValue * out, Index n) {
        auto __ip_04_lastValue = this->ip_04_lastValue;
        auto __ip_04_lastIndex = this->ip_04_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_04_lastIndex ? __ip_04_lastValue : this->ip_04_sigbuf[(Index)i]);
        }
    
        __ip_04_lastIndex = 0;
        this->ip_04_lastIndex = __ip_04_lastIndex;
    }
    
    void ip_05_perform(SampleValue * out, Index n) {
        auto __ip_05_lastValue = this->ip_05_lastValue;
        auto __ip_05_lastIndex = this->ip_05_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_05_lastIndex ? __ip_05_lastValue : this->ip_05_sigbuf[(Index)i]);
        }
    
        __ip_05_lastIndex = 0;
        this->ip_05_lastIndex = __ip_05_lastIndex;
    }
    
    void ip_06_perform(SampleValue * out, Index n) {
        auto __ip_06_lastValue = this->ip_06_lastValue;
        auto __ip_06_lastIndex = this->ip_06_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_06_lastIndex ? __ip_06_lastValue : this->ip_06_sigbuf[(Index)i]);
        }
    
        __ip_06_lastIndex = 0;
        this->ip_06_lastIndex = __ip_06_lastIndex;
    }
    
    void ip_07_perform(SampleValue * out, Index n) {
        auto __ip_07_lastValue = this->ip_07_lastValue;
        auto __ip_07_lastIndex = this->ip_07_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_07_lastIndex ? __ip_07_lastValue : this->ip_07_sigbuf[(Index)i]);
        }
    
        __ip_07_lastIndex = 0;
        this->ip_07_lastIndex = __ip_07_lastIndex;
    }
    
    void ip_08_perform(SampleValue * out, Index n) {
        auto __ip_08_lastValue = this->ip_08_lastValue;
        auto __ip_08_lastIndex = this->ip_08_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_08_lastIndex ? __ip_08_lastValue : this->ip_08_sigbuf[(Index)i]);
        }
    
        __ip_08_lastIndex = 0;
        this->ip_08_lastIndex = __ip_08_lastIndex;
    }
    
    void ip_09_perform(SampleValue * out, Index n) {
        auto __ip_09_lastValue = this->ip_09_lastValue;
        auto __ip_09_lastIndex = this->ip_09_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_09_lastIndex ? __ip_09_lastValue : this->ip_09_sigbuf[(Index)i]);
        }
    
        __ip_09_lastIndex = 0;
        this->ip_09_lastIndex = __ip_09_lastIndex;
    }
    
    void ip_10_perform(SampleValue * out, Index n) {
        auto __ip_10_lastValue = this->ip_10_lastValue;
        auto __ip_10_lastIndex = this->ip_10_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_10_lastIndex ? __ip_10_lastValue : this->ip_10_sigbuf[(Index)i]);
        }
    
        __ip_10_lastIndex = 0;
        this->ip_10_lastIndex = __ip_10_lastIndex;
    }
    
    void ip_11_perform(SampleValue * out, Index n) {
        auto __ip_11_lastValue = this->ip_11_lastValue;
        auto __ip_11_lastIndex = this->ip_11_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_11_lastIndex ? __ip_11_lastValue : this->ip_11_sigbuf[(Index)i]);
        }
    
        __ip_11_lastIndex = 0;
        this->ip_11_lastIndex = __ip_11_lastIndex;
    }
    
    void ip_12_perform(SampleValue * out, Index n) {
        auto __ip_12_lastValue = this->ip_12_lastValue;
        auto __ip_12_lastIndex = this->ip_12_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_12_lastIndex ? __ip_12_lastValue : this->ip_12_sigbuf[(Index)i]);
        }
    
        __ip_12_lastIndex = 0;
        this->ip_12_lastIndex = __ip_12_lastIndex;
    }
    
    void codebox_tilde_01_perform(
        const Sample * in1,
        const Sample * in2,
        const Sample * in3,
        const Sample * in4,
        const Sample * in5,
        const Sample * in6,
        const Sample * in7,
        const Sample * in8,
        const Sample * in9,
        const Sample * in10,
        const Sample * in11,
        const Sample * in12,
        const Sample * in13,
        SampleValue * out1,
        Index n
    ) {
        auto __codebox_tilde_01_svfBand = this->codebox_tilde_01_svfBand;
        auto __codebox_tilde_01_svfLow = this->codebox_tilde_01_svfLow;
        auto __codebox_tilde_01_modPhase = this->codebox_tilde_01_modPhase;
        auto __codebox_tilde_01_carrierPhase = this->codebox_tilde_01_carrierPhase;
        auto __codebox_tilde_01_pitchEnv = this->codebox_tilde_01_pitchEnv;
        auto __codebox_tilde_01_ampEnv = this->codebox_tilde_01_ampEnv;
        auto __codebox_tilde_01_hitLevel = this->codebox_tilde_01_hitLevel;
        auto __codebox_tilde_01_hitDrive = this->codebox_tilde_01_hitDrive;
        auto __codebox_tilde_01_hitClick = this->codebox_tilde_01_hitClick;
        auto __codebox_tilde_01_hitResQ = this->codebox_tilde_01_hitResQ;
        auto __codebox_tilde_01_hitResHz = this->codebox_tilde_01_hitResHz;
        auto __codebox_tilde_01_hitResMix = this->codebox_tilde_01_hitResMix;
        auto __codebox_tilde_01_hitFMRatio = this->codebox_tilde_01_hitFMRatio;
        auto __codebox_tilde_01_hitSweepDecay = this->codebox_tilde_01_hitSweepDecay;
        auto __codebox_tilde_01_hitSweep = this->codebox_tilde_01_hitSweep;
        auto __codebox_tilde_01_hitFM = this->codebox_tilde_01_hitFM;
        auto __codebox_tilde_01_hitDecay = this->codebox_tilde_01_hitDecay;
        auto __codebox_tilde_01_hitBase = this->codebox_tilde_01_hitBase;
        number sr = this->sr;
        Index i;
    
        for (i = 0; i < (Index)n; i++) {
            number trig = in1[(Index)i];
    
            if (trig > 0) {
                __codebox_tilde_01_hitBase = in2[(Index)i];//#map:_###_obj_###_:24
                __codebox_tilde_01_hitDecay = in5[(Index)i];//#map:_###_obj_###_:25
                __codebox_tilde_01_hitFM = in6[(Index)i];//#map:_###_obj_###_:26
                __codebox_tilde_01_hitSweep = in3[(Index)i];//#map:_###_obj_###_:27
                __codebox_tilde_01_hitSweepDecay = in4[(Index)i];//#map:_###_obj_###_:28
                __codebox_tilde_01_hitFMRatio = in7[(Index)i];//#map:_###_obj_###_:29
                __codebox_tilde_01_hitResMix = in8[(Index)i];//#map:_###_obj_###_:30
                __codebox_tilde_01_hitResHz = in9[(Index)i];//#map:_###_obj_###_:31
                __codebox_tilde_01_hitResQ = in10[(Index)i];//#map:_###_obj_###_:32
                __codebox_tilde_01_hitClick = in11[(Index)i];//#map:_###_obj_###_:33
                __codebox_tilde_01_hitDrive = in12[(Index)i];//#map:_###_obj_###_:34
                __codebox_tilde_01_hitLevel = in13[(Index)i];//#map:_###_obj_###_:35
                __codebox_tilde_01_ampEnv = 1;//#map:_###_obj_###_:36
                __codebox_tilde_01_pitchEnv = 1;//#map:_###_obj_###_:37
                __codebox_tilde_01_carrierPhase = 0;//#map:_###_obj_###_:38
                __codebox_tilde_01_modPhase = 0;//#map:_###_obj_###_:39
                __codebox_tilde_01_svfLow = 0;//#map:_###_obj_###_:40
                __codebox_tilde_01_svfBand = 0;//#map:_###_obj_###_:41
            }//#map:_###_obj_###_:23
    
            number ampCoef = rnbo_exp(
                (this->maximum(1, __codebox_tilde_01_hitDecay) * 0.001 * sr == 0. ? 0. : -6.907755 / (this->maximum(1, __codebox_tilde_01_hitDecay) * 0.001 * sr))
            );
    
            number pitchCoef = rnbo_exp(
                (this->maximum(1, __codebox_tilde_01_hitSweepDecay) * 0.001 * sr == 0. ? 0. : -6.907755 / (this->maximum(1, __codebox_tilde_01_hitSweepDecay) * 0.001 * sr))
            );
    
            __codebox_tilde_01_ampEnv *= ampCoef;//#map:_###_obj_###_:46
            __codebox_tilde_01_pitchEnv *= pitchCoef;//#map:_###_obj_###_:47
            auto base = this->maximum(10, __codebox_tilde_01_hitBase);
            number swept = base + this->maximum(0, __codebox_tilde_01_hitSweep) * __codebox_tilde_01_pitchEnv;
            number modFreq = swept * this->maximum(0.125, __codebox_tilde_01_hitFMRatio);
            __codebox_tilde_01_modPhase = this->wrap(__codebox_tilde_01_modPhase + ((sr == 0. ? 0. : modFreq / sr)), 0, 1);//#map:_###_obj_###_:52
            number fm = rnbo_sin(__codebox_tilde_01_modPhase * 6.283185307179586) * swept * this->maximum(0, __codebox_tilde_01_hitFM) * __codebox_tilde_01_pitchEnv;
            number carrierFreq = (swept + fm > sr * 0.45 ? sr * 0.45 : (swept + fm < 5 ? 5 : swept + fm));
    
            __codebox_tilde_01_carrierPhase = this->wrap(
                __codebox_tilde_01_carrierPhase + ((sr == 0. ? 0. : carrierFreq / sr)),
                0,
                1
            );//#map:_###_obj_###_:55
    
            number body = rnbo_sin(__codebox_tilde_01_carrierPhase * 6.283185307179586) * __codebox_tilde_01_ampEnv;
            number resonHz = (__codebox_tilde_01_hitResHz > sr * 0.2 ? sr * 0.2 : (__codebox_tilde_01_hitResHz < 20 ? 20 : __codebox_tilde_01_hitResHz));
            number f = 2 * rnbo_sin((sr == 0. ? 0. : 3.141592653589793 * resonHz / sr));
            number damping = (this->maximum(0.5, __codebox_tilde_01_hitResQ) == 0. ? 0. : (number)1 / this->maximum(0.5, __codebox_tilde_01_hitResQ));
            number resonInput = (this->maximum(f, 0.000001) == 0. ? 0. : trig * 0.25 / this->maximum(f, 0.000001));
            number high = resonInput - __codebox_tilde_01_svfLow - damping * __codebox_tilde_01_svfBand;
            __codebox_tilde_01_svfBand += f * high;//#map:_###_obj_###_:63
            __codebox_tilde_01_svfLow += f * __codebox_tilde_01_svfBand;//#map:_###_obj_###_:64
            number mix = (__codebox_tilde_01_hitResMix > 1 ? 1 : (__codebox_tilde_01_hitResMix < 0 ? 0 : __codebox_tilde_01_hitResMix));
            number click = trig * ((__codebox_tilde_01_hitClick > 1 ? 1 : (__codebox_tilde_01_hitClick < 0 ? 0 : __codebox_tilde_01_hitClick)));
            number raw = body * (1 - mix) + __codebox_tilde_01_svfBand * mix * 4 + click;
            auto drive = this->maximum(0.01, __codebox_tilde_01_hitDrive);
            out1[(Index)i] = ((rnbo_tanh(drive) == 0. ? 0. : rnbo_tanh(raw * drive) / rnbo_tanh(drive))) * ((__codebox_tilde_01_hitLevel > 1 ? 1 : (__codebox_tilde_01_hitLevel < 0 ? 0 : __codebox_tilde_01_hitLevel)));//#map:_###_obj_###_:70
        }
    
        this->codebox_tilde_01_hitBase = __codebox_tilde_01_hitBase;
        this->codebox_tilde_01_hitDecay = __codebox_tilde_01_hitDecay;
        this->codebox_tilde_01_hitFM = __codebox_tilde_01_hitFM;
        this->codebox_tilde_01_hitSweep = __codebox_tilde_01_hitSweep;
        this->codebox_tilde_01_hitSweepDecay = __codebox_tilde_01_hitSweepDecay;
        this->codebox_tilde_01_hitFMRatio = __codebox_tilde_01_hitFMRatio;
        this->codebox_tilde_01_hitResMix = __codebox_tilde_01_hitResMix;
        this->codebox_tilde_01_hitResHz = __codebox_tilde_01_hitResHz;
        this->codebox_tilde_01_hitResQ = __codebox_tilde_01_hitResQ;
        this->codebox_tilde_01_hitClick = __codebox_tilde_01_hitClick;
        this->codebox_tilde_01_hitDrive = __codebox_tilde_01_hitDrive;
        this->codebox_tilde_01_hitLevel = __codebox_tilde_01_hitLevel;
        this->codebox_tilde_01_ampEnv = __codebox_tilde_01_ampEnv;
        this->codebox_tilde_01_pitchEnv = __codebox_tilde_01_pitchEnv;
        this->codebox_tilde_01_carrierPhase = __codebox_tilde_01_carrierPhase;
        this->codebox_tilde_01_modPhase = __codebox_tilde_01_modPhase;
        this->codebox_tilde_01_svfLow = __codebox_tilde_01_svfLow;
        this->codebox_tilde_01_svfBand = __codebox_tilde_01_svfBand;
    }
    
    void dspexpr_01_perform(const Sample * in1, number in2, SampleValue * out1, Index n) {
        RNBO_UNUSED(in2);
        Index i;
    
        for (i = 0; i < (Index)n; i++) {
            out1[(Index)i] = in1[(Index)i] * 1;//#map:_###_obj_###_:1
        }
    }
    
    void signalforwarder_01_perform(const SampleValue * input, SampleValue * output, Index n) {
        copySignal(output, input, n);
    }
    
    void signalforwarder_02_perform(const SampleValue * input, SampleValue * output, Index n) {
        copySignal(output, input, n);
    }
    
    void stackprotect_perform(Index n) {
        RNBO_UNUSED(n);
        auto __stackprotect_count = this->stackprotect_count;
        __stackprotect_count = 0;
        this->stackprotect_count = __stackprotect_count;
    }
    
    void ip_01_init() {
        this->ip_01_lastValue = this->ip_01_value;
    }
    
    void ip_01_fillSigBuf() {
        if ((bool)(this->ip_01_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_01_lastIndex); i < k; i++) {
                if (this->ip_01_resetCount > 0) {
                    this->ip_01_sigbuf[(Index)i] = 1;
                    this->ip_01_resetCount--;
                } else {
                    this->ip_01_sigbuf[(Index)i] = this->ip_01_lastValue;
                }
            }
    
            this->ip_01_lastIndex = k;
        }
    }
    
    void ip_01_dspsetup(bool force) {
        if ((bool)(this->ip_01_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_01_lastIndex = 0;
        this->ip_01_setupDone = true;
    }
    
    void ip_02_init() {
        this->ip_02_lastValue = this->ip_02_value;
    }
    
    void ip_02_fillSigBuf() {
        if ((bool)(this->ip_02_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_02_lastIndex); i < k; i++) {
                if (this->ip_02_resetCount > 0) {
                    this->ip_02_sigbuf[(Index)i] = 1;
                    this->ip_02_resetCount--;
                } else {
                    this->ip_02_sigbuf[(Index)i] = this->ip_02_lastValue;
                }
            }
    
            this->ip_02_lastIndex = k;
        }
    }
    
    void ip_02_dspsetup(bool force) {
        if ((bool)(this->ip_02_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_02_lastIndex = 0;
        this->ip_02_setupDone = true;
    }
    
    void ip_03_init() {
        this->ip_03_lastValue = this->ip_03_value;
    }
    
    void ip_03_fillSigBuf() {
        if ((bool)(this->ip_03_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_03_lastIndex); i < k; i++) {
                if (this->ip_03_resetCount > 0) {
                    this->ip_03_sigbuf[(Index)i] = 1;
                    this->ip_03_resetCount--;
                } else {
                    this->ip_03_sigbuf[(Index)i] = this->ip_03_lastValue;
                }
            }
    
            this->ip_03_lastIndex = k;
        }
    }
    
    void ip_03_dspsetup(bool force) {
        if ((bool)(this->ip_03_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_03_lastIndex = 0;
        this->ip_03_setupDone = true;
    }
    
    void ip_04_init() {
        this->ip_04_lastValue = this->ip_04_value;
    }
    
    void ip_04_fillSigBuf() {
        if ((bool)(this->ip_04_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_04_lastIndex); i < k; i++) {
                if (this->ip_04_resetCount > 0) {
                    this->ip_04_sigbuf[(Index)i] = 1;
                    this->ip_04_resetCount--;
                } else {
                    this->ip_04_sigbuf[(Index)i] = this->ip_04_lastValue;
                }
            }
    
            this->ip_04_lastIndex = k;
        }
    }
    
    void ip_04_dspsetup(bool force) {
        if ((bool)(this->ip_04_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_04_lastIndex = 0;
        this->ip_04_setupDone = true;
    }
    
    void ip_05_init() {
        this->ip_05_lastValue = this->ip_05_value;
    }
    
    void ip_05_fillSigBuf() {
        if ((bool)(this->ip_05_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_05_lastIndex); i < k; i++) {
                if (this->ip_05_resetCount > 0) {
                    this->ip_05_sigbuf[(Index)i] = 1;
                    this->ip_05_resetCount--;
                } else {
                    this->ip_05_sigbuf[(Index)i] = this->ip_05_lastValue;
                }
            }
    
            this->ip_05_lastIndex = k;
        }
    }
    
    void ip_05_dspsetup(bool force) {
        if ((bool)(this->ip_05_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_05_lastIndex = 0;
        this->ip_05_setupDone = true;
    }
    
    void ip_06_init() {
        this->ip_06_lastValue = this->ip_06_value;
    }
    
    void ip_06_fillSigBuf() {
        if ((bool)(this->ip_06_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_06_lastIndex); i < k; i++) {
                if (this->ip_06_resetCount > 0) {
                    this->ip_06_sigbuf[(Index)i] = 1;
                    this->ip_06_resetCount--;
                } else {
                    this->ip_06_sigbuf[(Index)i] = this->ip_06_lastValue;
                }
            }
    
            this->ip_06_lastIndex = k;
        }
    }
    
    void ip_06_dspsetup(bool force) {
        if ((bool)(this->ip_06_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_06_lastIndex = 0;
        this->ip_06_setupDone = true;
    }
    
    void ip_07_init() {
        this->ip_07_lastValue = this->ip_07_value;
    }
    
    void ip_07_fillSigBuf() {
        if ((bool)(this->ip_07_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_07_lastIndex); i < k; i++) {
                if (this->ip_07_resetCount > 0) {
                    this->ip_07_sigbuf[(Index)i] = 1;
                    this->ip_07_resetCount--;
                } else {
                    this->ip_07_sigbuf[(Index)i] = this->ip_07_lastValue;
                }
            }
    
            this->ip_07_lastIndex = k;
        }
    }
    
    void ip_07_dspsetup(bool force) {
        if ((bool)(this->ip_07_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_07_lastIndex = 0;
        this->ip_07_setupDone = true;
    }
    
    void ip_08_init() {
        this->ip_08_lastValue = this->ip_08_value;
    }
    
    void ip_08_fillSigBuf() {
        if ((bool)(this->ip_08_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_08_lastIndex); i < k; i++) {
                if (this->ip_08_resetCount > 0) {
                    this->ip_08_sigbuf[(Index)i] = 1;
                    this->ip_08_resetCount--;
                } else {
                    this->ip_08_sigbuf[(Index)i] = this->ip_08_lastValue;
                }
            }
    
            this->ip_08_lastIndex = k;
        }
    }
    
    void ip_08_dspsetup(bool force) {
        if ((bool)(this->ip_08_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_08_lastIndex = 0;
        this->ip_08_setupDone = true;
    }
    
    void ip_09_init() {
        this->ip_09_lastValue = this->ip_09_value;
    }
    
    void ip_09_fillSigBuf() {
        if ((bool)(this->ip_09_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_09_lastIndex); i < k; i++) {
                if (this->ip_09_resetCount > 0) {
                    this->ip_09_sigbuf[(Index)i] = 1;
                    this->ip_09_resetCount--;
                } else {
                    this->ip_09_sigbuf[(Index)i] = this->ip_09_lastValue;
                }
            }
    
            this->ip_09_lastIndex = k;
        }
    }
    
    void ip_09_dspsetup(bool force) {
        if ((bool)(this->ip_09_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_09_lastIndex = 0;
        this->ip_09_setupDone = true;
    }
    
    void ip_10_init() {
        this->ip_10_lastValue = this->ip_10_value;
    }
    
    void ip_10_fillSigBuf() {
        if ((bool)(this->ip_10_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_10_lastIndex); i < k; i++) {
                if (this->ip_10_resetCount > 0) {
                    this->ip_10_sigbuf[(Index)i] = 1;
                    this->ip_10_resetCount--;
                } else {
                    this->ip_10_sigbuf[(Index)i] = this->ip_10_lastValue;
                }
            }
    
            this->ip_10_lastIndex = k;
        }
    }
    
    void ip_10_dspsetup(bool force) {
        if ((bool)(this->ip_10_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_10_lastIndex = 0;
        this->ip_10_setupDone = true;
    }
    
    void ip_11_init() {
        this->ip_11_lastValue = this->ip_11_value;
    }
    
    void ip_11_fillSigBuf() {
        if ((bool)(this->ip_11_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_11_lastIndex); i < k; i++) {
                if (this->ip_11_resetCount > 0) {
                    this->ip_11_sigbuf[(Index)i] = 1;
                    this->ip_11_resetCount--;
                } else {
                    this->ip_11_sigbuf[(Index)i] = this->ip_11_lastValue;
                }
            }
    
            this->ip_11_lastIndex = k;
        }
    }
    
    void ip_11_dspsetup(bool force) {
        if ((bool)(this->ip_11_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_11_lastIndex = 0;
        this->ip_11_setupDone = true;
    }
    
    void ip_12_init() {
        this->ip_12_lastValue = this->ip_12_value;
    }
    
    void ip_12_fillSigBuf() {
        if ((bool)(this->ip_12_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_12_lastIndex); i < k; i++) {
                if (this->ip_12_resetCount > 0) {
                    this->ip_12_sigbuf[(Index)i] = 1;
                    this->ip_12_resetCount--;
                } else {
                    this->ip_12_sigbuf[(Index)i] = this->ip_12_lastValue;
                }
            }
    
            this->ip_12_lastIndex = k;
        }
    }
    
    void ip_12_dspsetup(bool force) {
        if ((bool)(this->ip_12_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_12_lastIndex = 0;
        this->ip_12_setupDone = true;
    }
    
    bool stackprotect_check() {
        this->stackprotect_count++;
    
        if (this->stackprotect_count > 128) {
            console->log("STACK OVERFLOW DETECTED - stopped processing branch !");
            return true;
        }
    
        return false;
    }
    
    Index getPatcherSerial() const {
        return 0;
    }
    
    void sendParameter(ParameterIndex index, bool ignoreValue) {
        this->getPatcher()->sendParameter(index + this->parameterOffset, ignoreValue);
    }
    
    void scheduleParamInit(ParameterIndex index, Index order) {
        this->getPatcher()->scheduleParamInit(index + this->parameterOffset, order);
    }
    
    void updateTime(MillisecondTime time, EXTERNALENGINE* engine, bool inProcess = false) {
        RNBO_UNUSED(inProcess);
        RNBO_UNUSED(engine);
        this->_currentTime = time;
        auto offset = rnbo_fround(this->msToSamps(time - this->getEngine()->getCurrentTime(), this->sr));
    
        if (offset >= (SampleIndex)(this->vs))
            offset = (SampleIndex)(this->vs) - 1;
    
        if (offset < 0)
            offset = 0;
    
        this->sampleOffsetIntoNextAudioBuffer = (Index)(offset);
    }
    
    void assign_defaults()
    {
        ip_01_value = 0;
        ip_01_impulse = 0;
        ip_02_value = 0;
        ip_02_impulse = 0;
        ip_03_value = 0;
        ip_03_impulse = 0;
        ip_04_value = 0;
        ip_04_impulse = 0;
        ip_05_value = 0;
        ip_05_impulse = 0;
        ip_06_value = 0;
        ip_06_impulse = 0;
        ip_07_value = 0;
        ip_07_impulse = 0;
        ip_08_value = 0;
        ip_08_impulse = 0;
        ip_09_value = 0;
        ip_09_impulse = 0;
        ip_10_value = 0;
        ip_10_impulse = 0;
        ip_11_value = 0;
        ip_11_impulse = 0;
        ip_12_value = 0;
        ip_12_impulse = 0;
        codebox_tilde_01_in1 = 0;
        codebox_tilde_01_in2 = 0;
        codebox_tilde_01_in3 = 0;
        codebox_tilde_01_in4 = 0;
        codebox_tilde_01_in5 = 0;
        codebox_tilde_01_in6 = 0;
        codebox_tilde_01_in7 = 0;
        codebox_tilde_01_in8 = 0;
        codebox_tilde_01_in9 = 0;
        codebox_tilde_01_in10 = 0;
        codebox_tilde_01_in11 = 0;
        codebox_tilde_01_in12 = 0;
        codebox_tilde_01_in13 = 0;
        dspexpr_01_in1 = 0;
        dspexpr_01_in2 = 1;
        _currentTime = 0;
        audioProcessSampleCount = 0;
        sampleOffsetIntoNextAudioBuffer = 0;
        zeroBuffer = nullptr;
        dummyBuffer = nullptr;
        signals[0] = nullptr;
        signals[1] = nullptr;
        signals[2] = nullptr;
        signals[3] = nullptr;
        signals[4] = nullptr;
        signals[5] = nullptr;
        signals[6] = nullptr;
        signals[7] = nullptr;
        signals[8] = nullptr;
        signals[9] = nullptr;
        signals[10] = nullptr;
        signals[11] = nullptr;
        signals[12] = nullptr;
        signals[13] = nullptr;
        didAllocateSignals = 0;
        vs = 0;
        maxvs = 0;
        sr = 44100;
        invsr = 0.000022675736961451248;
        click_01_lastclick = -1;
        click_01_buf = nullptr;
        ip_01_lastIndex = 0;
        ip_01_lastValue = 0;
        ip_01_resetCount = 0;
        ip_01_sigbuf = nullptr;
        ip_01_setupDone = false;
        ip_02_lastIndex = 0;
        ip_02_lastValue = 0;
        ip_02_resetCount = 0;
        ip_02_sigbuf = nullptr;
        ip_02_setupDone = false;
        ip_03_lastIndex = 0;
        ip_03_lastValue = 0;
        ip_03_resetCount = 0;
        ip_03_sigbuf = nullptr;
        ip_03_setupDone = false;
        ip_04_lastIndex = 0;
        ip_04_lastValue = 0;
        ip_04_resetCount = 0;
        ip_04_sigbuf = nullptr;
        ip_04_setupDone = false;
        ip_05_lastIndex = 0;
        ip_05_lastValue = 0;
        ip_05_resetCount = 0;
        ip_05_sigbuf = nullptr;
        ip_05_setupDone = false;
        ip_06_lastIndex = 0;
        ip_06_lastValue = 0;
        ip_06_resetCount = 0;
        ip_06_sigbuf = nullptr;
        ip_06_setupDone = false;
        ip_07_lastIndex = 0;
        ip_07_lastValue = 0;
        ip_07_resetCount = 0;
        ip_07_sigbuf = nullptr;
        ip_07_setupDone = false;
        ip_08_lastIndex = 0;
        ip_08_lastValue = 0;
        ip_08_resetCount = 0;
        ip_08_sigbuf = nullptr;
        ip_08_setupDone = false;
        ip_09_lastIndex = 0;
        ip_09_lastValue = 0;
        ip_09_resetCount = 0;
        ip_09_sigbuf = nullptr;
        ip_09_setupDone = false;
        ip_10_lastIndex = 0;
        ip_10_lastValue = 0;
        ip_10_resetCount = 0;
        ip_10_sigbuf = nullptr;
        ip_10_setupDone = false;
        ip_11_lastIndex = 0;
        ip_11_lastValue = 0;
        ip_11_resetCount = 0;
        ip_11_sigbuf = nullptr;
        ip_11_setupDone = false;
        ip_12_lastIndex = 0;
        ip_12_lastValue = 0;
        ip_12_resetCount = 0;
        ip_12_sigbuf = nullptr;
        ip_12_setupDone = false;
        codebox_tilde_01_hitSweep = 150;
        codebox_tilde_01_hitSweepDecay = 32;
        codebox_tilde_01_hitFMRatio = 1.5;
        codebox_tilde_01_hitResMix = 0.22;
        codebox_tilde_01_hitResHz = 58;
        codebox_tilde_01_hitResQ = 8;
        codebox_tilde_01_hitClick = 0.08;
        codebox_tilde_01_hitDrive = 1.8;
        codebox_tilde_01_hitLevel = 0.5;
        codebox_tilde_01_hitBase = 48;
        codebox_tilde_01_hitDecay = 620;
        codebox_tilde_01_hitFM = 0.15;
        codebox_tilde_01_carrierPhase = 0;
        codebox_tilde_01_modPhase = 0;
        codebox_tilde_01_ampEnv = 0;
        codebox_tilde_01_pitchEnv = 0;
        codebox_tilde_01_svfLow = 0;
        codebox_tilde_01_svfBand = 0;
        stackprotect_count = 0;
        _voiceIndex = 0;
        _noteNumber = 0;
        isMuted = 1;
        parameterOffset = 0;
    }
    
    // member variables
    
        number ip_01_value;
        number ip_01_impulse;
        number ip_02_value;
        number ip_02_impulse;
        number ip_03_value;
        number ip_03_impulse;
        number ip_04_value;
        number ip_04_impulse;
        number ip_05_value;
        number ip_05_impulse;
        number ip_06_value;
        number ip_06_impulse;
        number ip_07_value;
        number ip_07_impulse;
        number ip_08_value;
        number ip_08_impulse;
        number ip_09_value;
        number ip_09_impulse;
        number ip_10_value;
        number ip_10_impulse;
        number ip_11_value;
        number ip_11_impulse;
        number ip_12_value;
        number ip_12_impulse;
        number codebox_tilde_01_in1;
        number codebox_tilde_01_in2;
        number codebox_tilde_01_in3;
        number codebox_tilde_01_in4;
        number codebox_tilde_01_in5;
        number codebox_tilde_01_in6;
        number codebox_tilde_01_in7;
        number codebox_tilde_01_in8;
        number codebox_tilde_01_in9;
        number codebox_tilde_01_in10;
        number codebox_tilde_01_in11;
        number codebox_tilde_01_in12;
        number codebox_tilde_01_in13;
        number dspexpr_01_in1;
        number dspexpr_01_in2;
        MillisecondTime _currentTime;
        UInt64 audioProcessSampleCount;
        Index sampleOffsetIntoNextAudioBuffer;
        signal zeroBuffer;
        signal dummyBuffer;
        SampleValue * signals[14];
        bool didAllocateSignals;
        Index vs;
        Index maxvs;
        number sr;
        number invsr;
        SampleIndex click_01_lastclick;
        signal click_01_buf;
        SampleIndex ip_01_lastIndex;
        number ip_01_lastValue;
        SampleIndex ip_01_resetCount;
        signal ip_01_sigbuf;
        bool ip_01_setupDone;
        SampleIndex ip_02_lastIndex;
        number ip_02_lastValue;
        SampleIndex ip_02_resetCount;
        signal ip_02_sigbuf;
        bool ip_02_setupDone;
        SampleIndex ip_03_lastIndex;
        number ip_03_lastValue;
        SampleIndex ip_03_resetCount;
        signal ip_03_sigbuf;
        bool ip_03_setupDone;
        SampleIndex ip_04_lastIndex;
        number ip_04_lastValue;
        SampleIndex ip_04_resetCount;
        signal ip_04_sigbuf;
        bool ip_04_setupDone;
        SampleIndex ip_05_lastIndex;
        number ip_05_lastValue;
        SampleIndex ip_05_resetCount;
        signal ip_05_sigbuf;
        bool ip_05_setupDone;
        SampleIndex ip_06_lastIndex;
        number ip_06_lastValue;
        SampleIndex ip_06_resetCount;
        signal ip_06_sigbuf;
        bool ip_06_setupDone;
        SampleIndex ip_07_lastIndex;
        number ip_07_lastValue;
        SampleIndex ip_07_resetCount;
        signal ip_07_sigbuf;
        bool ip_07_setupDone;
        SampleIndex ip_08_lastIndex;
        number ip_08_lastValue;
        SampleIndex ip_08_resetCount;
        signal ip_08_sigbuf;
        bool ip_08_setupDone;
        SampleIndex ip_09_lastIndex;
        number ip_09_lastValue;
        SampleIndex ip_09_resetCount;
        signal ip_09_sigbuf;
        bool ip_09_setupDone;
        SampleIndex ip_10_lastIndex;
        number ip_10_lastValue;
        SampleIndex ip_10_resetCount;
        signal ip_10_sigbuf;
        bool ip_10_setupDone;
        SampleIndex ip_11_lastIndex;
        number ip_11_lastValue;
        SampleIndex ip_11_resetCount;
        signal ip_11_sigbuf;
        bool ip_11_setupDone;
        SampleIndex ip_12_lastIndex;
        number ip_12_lastValue;
        SampleIndex ip_12_resetCount;
        signal ip_12_sigbuf;
        bool ip_12_setupDone;
        number codebox_tilde_01_hitSweep;
        number codebox_tilde_01_hitSweepDecay;
        number codebox_tilde_01_hitFMRatio;
        number codebox_tilde_01_hitResMix;
        number codebox_tilde_01_hitResHz;
        number codebox_tilde_01_hitResQ;
        number codebox_tilde_01_hitClick;
        number codebox_tilde_01_hitDrive;
        number codebox_tilde_01_hitLevel;
        number codebox_tilde_01_hitBase;
        number codebox_tilde_01_hitDecay;
        number codebox_tilde_01_hitFM;
        number codebox_tilde_01_carrierPhase;
        number codebox_tilde_01_modPhase;
        number codebox_tilde_01_ampEnv;
        number codebox_tilde_01_pitchEnv;
        number codebox_tilde_01_svfLow;
        number codebox_tilde_01_svfBand;
        number stackprotect_count;
        Index _voiceIndex;
        Int _noteNumber;
        Index isMuted;
        ParameterIndex parameterOffset;
        bool _isInitialized = false;
};

class RNBOSubpatcher_119 : public PatcherInterfaceImpl {
    
    friend class rnbomatic;
    
    public:
    
    RNBOSubpatcher_119()
    {}
    
    ~RNBOSubpatcher_119()
    {
        deallocateSignals();
    }
    
    Index getNumMidiInputPorts() const {
        return 0;
    }
    
    void processMidiEvent(MillisecondTime , int , ConstByteArray , Index ) {}
    
    Index getNumMidiOutputPorts() const {
        return 0;
    }
    
    void process(
        const SampleValue * const* inputs,
        Index numInputs,
        SampleValue * const* outputs,
        Index numOutputs,
        Index n
    ) {
        RNBO_UNUSED(numInputs);
        RNBO_UNUSED(inputs);
        this->vs = n;
        this->updateTime(this->getEngine()->getCurrentTime(), (ENGINE*)nullptr, true);
        SampleValue * out1 = (numOutputs >= 1 && outputs[0] ? outputs[0] : this->dummyBuffer);
        SampleValue * out2 = (numOutputs >= 2 && outputs[1] ? outputs[1] : this->dummyBuffer);
        this->click_02_perform(this->signals[0], n);
        this->ip_13_perform(this->signals[1], n);
        this->ip_14_perform(this->signals[2], n);
        this->ip_15_perform(this->signals[3], n);
        this->ip_16_perform(this->signals[4], n);
        this->ip_17_perform(this->signals[5], n);
        this->ip_18_perform(this->signals[6], n);
        this->ip_19_perform(this->signals[7], n);
        this->ip_20_perform(this->signals[8], n);
        this->ip_21_perform(this->signals[9], n);
        this->ip_22_perform(this->signals[10], n);
        this->ip_23_perform(this->signals[11], n);
        this->ip_24_perform(this->signals[12], n);
    
        this->codebox_tilde_02_perform(
            this->signals[0],
            this->signals[1],
            this->signals[2],
            this->signals[3],
            this->signals[4],
            this->signals[5],
            this->signals[6],
            this->signals[7],
            this->signals[8],
            this->signals[9],
            this->signals[10],
            this->signals[11],
            this->signals[12],
            this->signals[13],
            n
        );
    
        this->dspexpr_02_perform(this->signals[13], this->dspexpr_02_in2, this->signals[12], n);
        this->signalforwarder_03_perform(this->signals[12], out2, n);
        this->signalforwarder_04_perform(this->signals[12], out1, n);
        this->stackprotect_perform(n);
        this->audioProcessSampleCount += this->vs;
    }
    
    void prepareToProcess(number sampleRate, Index maxBlockSize, bool force) {
        RNBO_ASSERT(this->_isInitialized);
    
        if (this->maxvs < maxBlockSize || !this->didAllocateSignals) {
            Index i;
    
            for (i = 0; i < 14; i++) {
                this->signals[i] = resizeSignal(this->signals[i], this->maxvs, maxBlockSize);
            }
    
            this->click_02_buf = resizeSignal(this->click_02_buf, this->maxvs, maxBlockSize);
            this->ip_13_sigbuf = resizeSignal(this->ip_13_sigbuf, this->maxvs, maxBlockSize);
            this->ip_14_sigbuf = resizeSignal(this->ip_14_sigbuf, this->maxvs, maxBlockSize);
            this->ip_15_sigbuf = resizeSignal(this->ip_15_sigbuf, this->maxvs, maxBlockSize);
            this->ip_16_sigbuf = resizeSignal(this->ip_16_sigbuf, this->maxvs, maxBlockSize);
            this->ip_17_sigbuf = resizeSignal(this->ip_17_sigbuf, this->maxvs, maxBlockSize);
            this->ip_18_sigbuf = resizeSignal(this->ip_18_sigbuf, this->maxvs, maxBlockSize);
            this->ip_19_sigbuf = resizeSignal(this->ip_19_sigbuf, this->maxvs, maxBlockSize);
            this->ip_20_sigbuf = resizeSignal(this->ip_20_sigbuf, this->maxvs, maxBlockSize);
            this->ip_21_sigbuf = resizeSignal(this->ip_21_sigbuf, this->maxvs, maxBlockSize);
            this->ip_22_sigbuf = resizeSignal(this->ip_22_sigbuf, this->maxvs, maxBlockSize);
            this->ip_23_sigbuf = resizeSignal(this->ip_23_sigbuf, this->maxvs, maxBlockSize);
            this->ip_24_sigbuf = resizeSignal(this->ip_24_sigbuf, this->maxvs, maxBlockSize);
            this->zeroBuffer = resizeSignal(this->zeroBuffer, this->maxvs, maxBlockSize);
            this->dummyBuffer = resizeSignal(this->dummyBuffer, this->maxvs, maxBlockSize);
            this->didAllocateSignals = true;
        }
    
        const bool sampleRateChanged = sampleRate != this->sr;
        const bool maxvsChanged = maxBlockSize != this->maxvs;
        const bool forceDSPSetup = sampleRateChanged || maxvsChanged || force;
    
        if (sampleRateChanged || maxvsChanged) {
            this->vs = maxBlockSize;
            this->maxvs = maxBlockSize;
            this->sr = sampleRate;
            this->invsr = 1 / sampleRate;
        }
    
        this->ip_13_dspsetup(forceDSPSetup);
        this->ip_14_dspsetup(forceDSPSetup);
        this->ip_15_dspsetup(forceDSPSetup);
        this->ip_16_dspsetup(forceDSPSetup);
        this->ip_17_dspsetup(forceDSPSetup);
        this->ip_18_dspsetup(forceDSPSetup);
        this->ip_19_dspsetup(forceDSPSetup);
        this->ip_20_dspsetup(forceDSPSetup);
        this->ip_21_dspsetup(forceDSPSetup);
        this->ip_22_dspsetup(forceDSPSetup);
        this->ip_23_dspsetup(forceDSPSetup);
        this->ip_24_dspsetup(forceDSPSetup);
    
        if (sampleRateChanged)
            this->onSampleRateChanged(sampleRate);
    }
    
    number msToSamps(MillisecondTime ms, number sampleRate) {
        return ms * sampleRate * 0.001;
    }
    
    MillisecondTime sampsToMs(SampleIndex samps) {
        return samps * (this->invsr * 1000);
    }
    
    Index getNumInputChannels() const {
        return 0;
    }
    
    Index getNumOutputChannels() const {
        return 2;
    }
    
    void getPreset(PatcherStateInterface& ) {}
    
    void setPreset(MillisecondTime , PatcherStateInterface& ) {}
    
    void setParameterValue(ParameterIndex , ParameterValue , MillisecondTime ) {}
    
    void processParameterEvent(ParameterIndex index, ParameterValue value, MillisecondTime time) {
        this->setParameterValue(index, value, time);
    }
    
    void processParameterBangEvent(ParameterIndex index, MillisecondTime time) {
        this->setParameterValue(index, this->getParameterValue(index), time);
    }
    
    void processNormalizedParameterEvent(ParameterIndex index, ParameterValue value, MillisecondTime time) {
        this->setParameterValueNormalized(index, value, time);
    }
    
    ParameterValue getParameterValue(ParameterIndex index)  {
        switch (index) {
        default:
            {
            return 0;
            }
        }
    }
    
    ParameterIndex getNumSignalInParameters() const {
        return 0;
    }
    
    ParameterIndex getNumSignalOutParameters() const {
        return 0;
    }
    
    ParameterIndex getNumParameters() const {
        return 0;
    }
    
    ConstCharPointer getParameterName(ParameterIndex index) const {
        switch (index) {
        default:
            {
            return "bogus";
            }
        }
    }
    
    ConstCharPointer getParameterId(ParameterIndex index) const {
        switch (index) {
        default:
            {
            return "bogus";
            }
        }
    }
    
    void getParameterInfo(ParameterIndex , ParameterInfo * ) const {}
    
    ParameterValue applyStepsToNormalizedParameterValue(ParameterValue normalizedValue, int steps) const {
        if (steps == 1) {
            if (normalizedValue > 0) {
                normalizedValue = 1.;
            }
        } else {
            ParameterValue oneStep = (number)1. / (steps - 1);
            ParameterValue numberOfSteps = rnbo_fround(normalizedValue / oneStep * 1 / (number)1) * (number)1;
            normalizedValue = numberOfSteps * oneStep;
        }
    
        return normalizedValue;
    }
    
    ParameterValue convertToNormalizedParameterValue(ParameterIndex index, ParameterValue value) const {
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    ParameterValue convertFromNormalizedParameterValue(ParameterIndex index, ParameterValue value) const {
        value = (value < 0 ? 0 : (value > 1 ? 1 : value));
    
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    ParameterValue constrainParameterValue(ParameterIndex index, ParameterValue value) const {
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    void processNumMessage(MessageTag , MessageTag , MillisecondTime , number ) {}
    
    void processListMessage(MessageTag , MessageTag , MillisecondTime , const list& ) {}
    
    void processBangMessage(MessageTag , MessageTag , MillisecondTime ) {}
    
    MessageTagInfo resolveTag(MessageTag tag) const {
        switch (tag) {
    
        }
    
        return nullptr;
    }
    
    DataRef* getDataRef(DataRefIndex index)  {
        switch (index) {
        default:
            {
            return nullptr;
            }
        }
    }
    
    DataRefIndex getNumDataRefs() const {
        return 0;
    }
    
    void processDataViewUpdate(DataRefIndex , MillisecondTime ) {}
    
    void initialize() {
        RNBO_ASSERT(!this->_isInitialized);
        this->assign_defaults();
        this->applyState();
        this->_isInitialized = true;
    }
    
    protected:
    
    void updateTime(MillisecondTime time, INTERNALENGINE*, bool inProcess = false) {
    	if (time == TimeNow) time = getTopLevelPatcher()->getPatcherTime();
    	getTopLevelPatcher()->processInternalEvents(time);
    	updateTime(time, (EXTERNALENGINE*)nullptr);
    }
    
    RNBOSubpatcher_119* operator->() {
        return this;
    }
    const RNBOSubpatcher_119* operator->() const {
        return this;
    }
    virtual rnbomatic* getPatcher() const {
        return static_cast<rnbomatic *>(_parentPatcher);
    }
    
    rnbomatic* getTopLevelPatcher() {
        return this->getPatcher()->getTopLevelPatcher();
    }
    
    void cancelClockEvents()
    {
    }
    
    number maximum(number x, number y) {
        return (x < y ? y : x);
    }
    
    number wrap(number x, number low, number high) {
        number lo;
        number hi;
    
        if (low == high)
            return low;
    
        if (low > high) {
            hi = low;
            lo = high;
        } else {
            lo = low;
            hi = high;
        }
    
        number range = hi - lo;
    
        if (x >= lo && x < hi)
            return x;
    
        if (range <= 0.000000001)
            return lo;
    
        Int numWraps = (Int)(trunc((x - lo) / range));
        numWraps = numWraps - ((x < lo ? 1 : 0));
        number result = x - range * numWraps;
    
        if (result >= hi)
            return result - range;
        else
            return result;
    }
    
    MillisecondTime getPatcherTime() const {
        return this->_currentTime;
    }
    
    void eventinlet_15_out1_bang_bang() {
        this->ip_13_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_15_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_13_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_13_value_set(converted);
        }
    }
    
    void eventinlet_16_out1_bang_bang() {
        this->ip_14_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_16_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_14_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_14_value_set(converted);
        }
    }
    
    void eventinlet_17_out1_bang_bang() {
        this->ip_15_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_17_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_15_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_15_value_set(converted);
        }
    }
    
    void eventinlet_18_out1_bang_bang() {
        this->ip_16_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_18_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_16_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_16_value_set(converted);
        }
    }
    
    void eventinlet_19_out1_bang_bang() {
        this->ip_17_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_19_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_17_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_17_value_set(converted);
        }
    }
    
    void eventinlet_20_out1_bang_bang() {
        this->ip_18_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_20_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_18_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_18_value_set(converted);
        }
    }
    
    void eventinlet_21_out1_bang_bang() {
        this->ip_19_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_21_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_19_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_19_value_set(converted);
        }
    }
    
    void eventinlet_22_out1_bang_bang() {
        this->ip_20_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_22_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_20_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_20_value_set(converted);
        }
    }
    
    void eventinlet_23_out1_bang_bang() {
        this->ip_21_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_23_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_21_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_21_value_set(converted);
        }
    }
    
    void eventinlet_24_out1_bang_bang() {
        this->ip_22_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_24_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_22_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_22_value_set(converted);
        }
    }
    
    void eventinlet_25_out1_bang_bang() {
        this->ip_23_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_25_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_23_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_23_value_set(converted);
        }
    }
    
    void eventinlet_26_out1_bang_bang() {
        this->ip_24_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_26_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_24_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_24_value_set(converted);
        }
    }
    
    void deallocateSignals() {
        Index i;
    
        for (i = 0; i < 14; i++) {
            this->signals[i] = freeSignal(this->signals[i]);
        }
    
        this->click_02_buf = freeSignal(this->click_02_buf);
        this->ip_13_sigbuf = freeSignal(this->ip_13_sigbuf);
        this->ip_14_sigbuf = freeSignal(this->ip_14_sigbuf);
        this->ip_15_sigbuf = freeSignal(this->ip_15_sigbuf);
        this->ip_16_sigbuf = freeSignal(this->ip_16_sigbuf);
        this->ip_17_sigbuf = freeSignal(this->ip_17_sigbuf);
        this->ip_18_sigbuf = freeSignal(this->ip_18_sigbuf);
        this->ip_19_sigbuf = freeSignal(this->ip_19_sigbuf);
        this->ip_20_sigbuf = freeSignal(this->ip_20_sigbuf);
        this->ip_21_sigbuf = freeSignal(this->ip_21_sigbuf);
        this->ip_22_sigbuf = freeSignal(this->ip_22_sigbuf);
        this->ip_23_sigbuf = freeSignal(this->ip_23_sigbuf);
        this->ip_24_sigbuf = freeSignal(this->ip_24_sigbuf);
        this->zeroBuffer = freeSignal(this->zeroBuffer);
        this->dummyBuffer = freeSignal(this->dummyBuffer);
    }
    
    Index getMaxBlockSize() const {
        return this->maxvs;
    }
    
    number getSampleRate() const {
        return this->sr;
    }
    
    bool hasFixedVectorSize() const {
        return false;
    }
    
    void setProbingTarget(MessageTag ) {}
    
    void initializeObjects() {
        this->ip_13_init();
        this->ip_14_init();
        this->ip_15_init();
        this->ip_16_init();
        this->ip_17_init();
        this->ip_18_init();
        this->ip_19_init();
        this->ip_20_init();
        this->ip_21_init();
        this->ip_22_init();
        this->ip_23_init();
        this->ip_24_init();
    }
    
    Index getIsMuted()  {
        return this->isMuted;
    }
    
    void setIsMuted(Index v)  {
        this->isMuted = v;
    }
    
    void onSampleRateChanged(double ) {}
    
    void extractState(PatcherStateInterface& ) {}
    
    void applyState() {}
    
    void setParameterOffset(ParameterIndex offset) {
        this->parameterOffset = offset;
    }
    
    void processClockEvent(MillisecondTime , ClockId , bool , ParameterValue ) {}
    
    void processOutletAtCurrentTime(EngineLink* , OutletIndex , ParameterValue ) {}
    
    void processOutletEvent(
        EngineLink* sender,
        OutletIndex index,
        ParameterValue value,
        MillisecondTime time
    ) {
        this->updateTime(time, (ENGINE*)nullptr);
        this->processOutletAtCurrentTime(sender, index, value);
    }
    
    void sendOutlet(OutletIndex index, ParameterValue value) {
        this->getEngine()->sendOutlet(this, index, value);
    }
    
    void startup() {}
    
    void fillDataRef(DataRefIndex , DataRef& ) {}
    
    void allocateDataRefs() {}
    
    void ip_13_value_set(number v) {
        this->ip_13_value = v;
        this->ip_13_fillSigBuf();
        this->ip_13_lastValue = v;
    }
    
    void eventinlet_15_out1_number_set(number v) {
        this->ip_13_value_set(v);
    }
    
    void ip_14_value_set(number v) {
        this->ip_14_value = v;
        this->ip_14_fillSigBuf();
        this->ip_14_lastValue = v;
    }
    
    void eventinlet_16_out1_number_set(number v) {
        this->ip_14_value_set(v);
    }
    
    void ip_15_value_set(number v) {
        this->ip_15_value = v;
        this->ip_15_fillSigBuf();
        this->ip_15_lastValue = v;
    }
    
    void eventinlet_17_out1_number_set(number v) {
        this->ip_15_value_set(v);
    }
    
    void ip_16_value_set(number v) {
        this->ip_16_value = v;
        this->ip_16_fillSigBuf();
        this->ip_16_lastValue = v;
    }
    
    void eventinlet_18_out1_number_set(number v) {
        this->ip_16_value_set(v);
    }
    
    void ip_17_value_set(number v) {
        this->ip_17_value = v;
        this->ip_17_fillSigBuf();
        this->ip_17_lastValue = v;
    }
    
    void eventinlet_19_out1_number_set(number v) {
        this->ip_17_value_set(v);
    }
    
    void ip_18_value_set(number v) {
        this->ip_18_value = v;
        this->ip_18_fillSigBuf();
        this->ip_18_lastValue = v;
    }
    
    void eventinlet_20_out1_number_set(number v) {
        this->ip_18_value_set(v);
    }
    
    void ip_19_value_set(number v) {
        this->ip_19_value = v;
        this->ip_19_fillSigBuf();
        this->ip_19_lastValue = v;
    }
    
    void eventinlet_21_out1_number_set(number v) {
        this->ip_19_value_set(v);
    }
    
    void ip_20_value_set(number v) {
        this->ip_20_value = v;
        this->ip_20_fillSigBuf();
        this->ip_20_lastValue = v;
    }
    
    void eventinlet_22_out1_number_set(number v) {
        this->ip_20_value_set(v);
    }
    
    void ip_21_value_set(number v) {
        this->ip_21_value = v;
        this->ip_21_fillSigBuf();
        this->ip_21_lastValue = v;
    }
    
    void eventinlet_23_out1_number_set(number v) {
        this->ip_21_value_set(v);
    }
    
    void ip_22_value_set(number v) {
        this->ip_22_value = v;
        this->ip_22_fillSigBuf();
        this->ip_22_lastValue = v;
    }
    
    void eventinlet_24_out1_number_set(number v) {
        this->ip_22_value_set(v);
    }
    
    void ip_23_value_set(number v) {
        this->ip_23_value = v;
        this->ip_23_fillSigBuf();
        this->ip_23_lastValue = v;
    }
    
    void eventinlet_25_out1_number_set(number v) {
        this->ip_23_value_set(v);
    }
    
    void ip_24_value_set(number v) {
        this->ip_24_value = v;
        this->ip_24_fillSigBuf();
        this->ip_24_lastValue = v;
    }
    
    void eventinlet_26_out1_number_set(number v) {
        this->ip_24_value_set(v);
    }
    
    void click_02_click_number_set(number v) {
        for (SampleIndex i = (SampleIndex)(this->click_02_lastclick + 1); i < this->sampleOffsetIntoNextAudioBuffer; i++) {
            this->click_02_buf[(Index)i] = 0;
        }
    
        this->click_02_lastclick = this->sampleOffsetIntoNextAudioBuffer;
        this->click_02_buf[(Index)this->click_02_lastclick] = v;
    }
    
    void click_02_click_bang_bang() {
        this->click_02_click_number_set(1);
    }
    
    void eventinlet_14_out1_bang_bang() {
        this->click_02_click_bang_bang();
    }
    
    void eventinlet_14_out1_number_set(number v) {
        this->click_02_click_number_set(v);
    }
    
    template<typename LISTTYPE> void eventinlet_14_out1_list_set(const LISTTYPE& v) {
        {
            number converted = (v->length > 0 ? v[0] : 0);
            this->click_02_click_number_set(converted);
        }
    }
    
    void ip_13_value_bang() {
        number v = this->ip_13_value;
        this->ip_13_fillSigBuf();
        this->ip_13_lastValue = v;
    }
    
    void ip_13_impulse_set(number v) {
        this->ip_13_impulse = v;
        this->ip_13_fillSigBuf();
        this->ip_13_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_13_resetCount = lengthInSamples;
    }
    
    void ip_14_value_bang() {
        number v = this->ip_14_value;
        this->ip_14_fillSigBuf();
        this->ip_14_lastValue = v;
    }
    
    void ip_14_impulse_set(number v) {
        this->ip_14_impulse = v;
        this->ip_14_fillSigBuf();
        this->ip_14_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_14_resetCount = lengthInSamples;
    }
    
    void ip_15_value_bang() {
        number v = this->ip_15_value;
        this->ip_15_fillSigBuf();
        this->ip_15_lastValue = v;
    }
    
    void ip_15_impulse_set(number v) {
        this->ip_15_impulse = v;
        this->ip_15_fillSigBuf();
        this->ip_15_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_15_resetCount = lengthInSamples;
    }
    
    void ip_16_value_bang() {
        number v = this->ip_16_value;
        this->ip_16_fillSigBuf();
        this->ip_16_lastValue = v;
    }
    
    void ip_16_impulse_set(number v) {
        this->ip_16_impulse = v;
        this->ip_16_fillSigBuf();
        this->ip_16_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_16_resetCount = lengthInSamples;
    }
    
    void ip_17_value_bang() {
        number v = this->ip_17_value;
        this->ip_17_fillSigBuf();
        this->ip_17_lastValue = v;
    }
    
    void ip_17_impulse_set(number v) {
        this->ip_17_impulse = v;
        this->ip_17_fillSigBuf();
        this->ip_17_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_17_resetCount = lengthInSamples;
    }
    
    void ip_18_value_bang() {
        number v = this->ip_18_value;
        this->ip_18_fillSigBuf();
        this->ip_18_lastValue = v;
    }
    
    void ip_18_impulse_set(number v) {
        this->ip_18_impulse = v;
        this->ip_18_fillSigBuf();
        this->ip_18_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_18_resetCount = lengthInSamples;
    }
    
    void ip_19_value_bang() {
        number v = this->ip_19_value;
        this->ip_19_fillSigBuf();
        this->ip_19_lastValue = v;
    }
    
    void ip_19_impulse_set(number v) {
        this->ip_19_impulse = v;
        this->ip_19_fillSigBuf();
        this->ip_19_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_19_resetCount = lengthInSamples;
    }
    
    void ip_20_value_bang() {
        number v = this->ip_20_value;
        this->ip_20_fillSigBuf();
        this->ip_20_lastValue = v;
    }
    
    void ip_20_impulse_set(number v) {
        this->ip_20_impulse = v;
        this->ip_20_fillSigBuf();
        this->ip_20_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_20_resetCount = lengthInSamples;
    }
    
    void ip_21_value_bang() {
        number v = this->ip_21_value;
        this->ip_21_fillSigBuf();
        this->ip_21_lastValue = v;
    }
    
    void ip_21_impulse_set(number v) {
        this->ip_21_impulse = v;
        this->ip_21_fillSigBuf();
        this->ip_21_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_21_resetCount = lengthInSamples;
    }
    
    void ip_22_value_bang() {
        number v = this->ip_22_value;
        this->ip_22_fillSigBuf();
        this->ip_22_lastValue = v;
    }
    
    void ip_22_impulse_set(number v) {
        this->ip_22_impulse = v;
        this->ip_22_fillSigBuf();
        this->ip_22_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_22_resetCount = lengthInSamples;
    }
    
    void ip_23_value_bang() {
        number v = this->ip_23_value;
        this->ip_23_fillSigBuf();
        this->ip_23_lastValue = v;
    }
    
    void ip_23_impulse_set(number v) {
        this->ip_23_impulse = v;
        this->ip_23_fillSigBuf();
        this->ip_23_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_23_resetCount = lengthInSamples;
    }
    
    void ip_24_value_bang() {
        number v = this->ip_24_value;
        this->ip_24_fillSigBuf();
        this->ip_24_lastValue = v;
    }
    
    void ip_24_impulse_set(number v) {
        this->ip_24_impulse = v;
        this->ip_24_fillSigBuf();
        this->ip_24_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_24_resetCount = lengthInSamples;
    }
    
    void click_02_perform(SampleValue * out, Index n) {
        auto __click_02_lastclick = this->click_02_lastclick;
    
        for (SampleIndex i = 0; i <= __click_02_lastclick; i++) {
            out[(Index)i] = this->click_02_buf[(Index)i];
        }
    
        for (SampleIndex i = (SampleIndex)(__click_02_lastclick + 1); i < (SampleIndex)(n); i++) {
            out[(Index)i] = 0;
        }
    
        __click_02_lastclick = -1;
        this->click_02_lastclick = __click_02_lastclick;
    }
    
    void ip_13_perform(SampleValue * out, Index n) {
        auto __ip_13_lastValue = this->ip_13_lastValue;
        auto __ip_13_lastIndex = this->ip_13_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_13_lastIndex ? __ip_13_lastValue : this->ip_13_sigbuf[(Index)i]);
        }
    
        __ip_13_lastIndex = 0;
        this->ip_13_lastIndex = __ip_13_lastIndex;
    }
    
    void ip_14_perform(SampleValue * out, Index n) {
        auto __ip_14_lastValue = this->ip_14_lastValue;
        auto __ip_14_lastIndex = this->ip_14_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_14_lastIndex ? __ip_14_lastValue : this->ip_14_sigbuf[(Index)i]);
        }
    
        __ip_14_lastIndex = 0;
        this->ip_14_lastIndex = __ip_14_lastIndex;
    }
    
    void ip_15_perform(SampleValue * out, Index n) {
        auto __ip_15_lastValue = this->ip_15_lastValue;
        auto __ip_15_lastIndex = this->ip_15_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_15_lastIndex ? __ip_15_lastValue : this->ip_15_sigbuf[(Index)i]);
        }
    
        __ip_15_lastIndex = 0;
        this->ip_15_lastIndex = __ip_15_lastIndex;
    }
    
    void ip_16_perform(SampleValue * out, Index n) {
        auto __ip_16_lastValue = this->ip_16_lastValue;
        auto __ip_16_lastIndex = this->ip_16_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_16_lastIndex ? __ip_16_lastValue : this->ip_16_sigbuf[(Index)i]);
        }
    
        __ip_16_lastIndex = 0;
        this->ip_16_lastIndex = __ip_16_lastIndex;
    }
    
    void ip_17_perform(SampleValue * out, Index n) {
        auto __ip_17_lastValue = this->ip_17_lastValue;
        auto __ip_17_lastIndex = this->ip_17_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_17_lastIndex ? __ip_17_lastValue : this->ip_17_sigbuf[(Index)i]);
        }
    
        __ip_17_lastIndex = 0;
        this->ip_17_lastIndex = __ip_17_lastIndex;
    }
    
    void ip_18_perform(SampleValue * out, Index n) {
        auto __ip_18_lastValue = this->ip_18_lastValue;
        auto __ip_18_lastIndex = this->ip_18_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_18_lastIndex ? __ip_18_lastValue : this->ip_18_sigbuf[(Index)i]);
        }
    
        __ip_18_lastIndex = 0;
        this->ip_18_lastIndex = __ip_18_lastIndex;
    }
    
    void ip_19_perform(SampleValue * out, Index n) {
        auto __ip_19_lastValue = this->ip_19_lastValue;
        auto __ip_19_lastIndex = this->ip_19_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_19_lastIndex ? __ip_19_lastValue : this->ip_19_sigbuf[(Index)i]);
        }
    
        __ip_19_lastIndex = 0;
        this->ip_19_lastIndex = __ip_19_lastIndex;
    }
    
    void ip_20_perform(SampleValue * out, Index n) {
        auto __ip_20_lastValue = this->ip_20_lastValue;
        auto __ip_20_lastIndex = this->ip_20_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_20_lastIndex ? __ip_20_lastValue : this->ip_20_sigbuf[(Index)i]);
        }
    
        __ip_20_lastIndex = 0;
        this->ip_20_lastIndex = __ip_20_lastIndex;
    }
    
    void ip_21_perform(SampleValue * out, Index n) {
        auto __ip_21_lastValue = this->ip_21_lastValue;
        auto __ip_21_lastIndex = this->ip_21_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_21_lastIndex ? __ip_21_lastValue : this->ip_21_sigbuf[(Index)i]);
        }
    
        __ip_21_lastIndex = 0;
        this->ip_21_lastIndex = __ip_21_lastIndex;
    }
    
    void ip_22_perform(SampleValue * out, Index n) {
        auto __ip_22_lastValue = this->ip_22_lastValue;
        auto __ip_22_lastIndex = this->ip_22_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_22_lastIndex ? __ip_22_lastValue : this->ip_22_sigbuf[(Index)i]);
        }
    
        __ip_22_lastIndex = 0;
        this->ip_22_lastIndex = __ip_22_lastIndex;
    }
    
    void ip_23_perform(SampleValue * out, Index n) {
        auto __ip_23_lastValue = this->ip_23_lastValue;
        auto __ip_23_lastIndex = this->ip_23_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_23_lastIndex ? __ip_23_lastValue : this->ip_23_sigbuf[(Index)i]);
        }
    
        __ip_23_lastIndex = 0;
        this->ip_23_lastIndex = __ip_23_lastIndex;
    }
    
    void ip_24_perform(SampleValue * out, Index n) {
        auto __ip_24_lastValue = this->ip_24_lastValue;
        auto __ip_24_lastIndex = this->ip_24_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_24_lastIndex ? __ip_24_lastValue : this->ip_24_sigbuf[(Index)i]);
        }
    
        __ip_24_lastIndex = 0;
        this->ip_24_lastIndex = __ip_24_lastIndex;
    }
    
    void codebox_tilde_02_perform(
        const Sample * in1,
        const Sample * in2,
        const Sample * in3,
        const Sample * in4,
        const Sample * in5,
        const Sample * in6,
        const Sample * in7,
        const Sample * in8,
        const Sample * in9,
        const Sample * in10,
        const Sample * in11,
        const Sample * in12,
        const Sample * in13,
        SampleValue * out1,
        Index n
    ) {
        auto __codebox_tilde_02_noiseState = this->codebox_tilde_02_noiseState;
        auto __codebox_tilde_02_svfIc2 = this->codebox_tilde_02_svfIc2;
        auto __codebox_tilde_02_svfIc1 = this->codebox_tilde_02_svfIc1;
        auto __codebox_tilde_02_modPhase = this->codebox_tilde_02_modPhase;
        auto __codebox_tilde_02_modePhase = this->codebox_tilde_02_modePhase;
        auto __codebox_tilde_02_bodyPhase = this->codebox_tilde_02_bodyPhase;
        auto __codebox_tilde_02_snapEnv = this->codebox_tilde_02_snapEnv;
        auto __codebox_tilde_02_bendEnv = this->codebox_tilde_02_bendEnv;
        auto __codebox_tilde_02_noiseEnv = this->codebox_tilde_02_noiseEnv;
        auto __codebox_tilde_02_bodyEnv = this->codebox_tilde_02_bodyEnv;
        auto __codebox_tilde_02_hitLevel = this->codebox_tilde_02_hitLevel;
        auto __codebox_tilde_02_hitDrive = this->codebox_tilde_02_hitDrive;
        auto __codebox_tilde_02_hitSnap = this->codebox_tilde_02_hitSnap;
        auto __codebox_tilde_02_hitNoiseQ = this->codebox_tilde_02_hitNoiseQ;
        auto __codebox_tilde_02_hitNoiseLevel = this->codebox_tilde_02_hitNoiseLevel;
        auto __codebox_tilde_02_hitBodyLevel = this->codebox_tilde_02_hitBodyLevel;
        auto __codebox_tilde_02_hitNoiseHz = this->codebox_tilde_02_hitNoiseHz;
        auto __codebox_tilde_02_hitBodyFM = this->codebox_tilde_02_hitBodyFM;
        auto __codebox_tilde_02_hitBodyDecay = this->codebox_tilde_02_hitBodyDecay;
        auto __codebox_tilde_02_hitNoiseDecay = this->codebox_tilde_02_hitNoiseDecay;
        auto __codebox_tilde_02_hitBodyBend = this->codebox_tilde_02_hitBodyBend;
        auto __codebox_tilde_02_hitBodyHz = this->codebox_tilde_02_hitBodyHz;
        number sr = this->sr;
        number bendCoef = rnbo_exp((0.022 * sr == 0. ? 0. : -6.907755 / (0.022 * sr)));
        number snapCoef = rnbo_exp((0.014 * sr == 0. ? 0. : -6.907755 / (0.014 * sr)));
        Index i;
    
        for (i = 0; i < (Index)n; i++) {
            number trig = in1[(Index)i];
    
            if (trig > 0) {
                __codebox_tilde_02_hitBodyHz = in2[(Index)i];//#map:_###_obj_###_:31
                __codebox_tilde_02_hitBodyBend = in3[(Index)i];//#map:_###_obj_###_:32
                __codebox_tilde_02_hitNoiseDecay = in4[(Index)i];//#map:_###_obj_###_:33
                __codebox_tilde_02_hitBodyDecay = in5[(Index)i];//#map:_###_obj_###_:34
                __codebox_tilde_02_hitBodyFM = in6[(Index)i];//#map:_###_obj_###_:35
                __codebox_tilde_02_hitNoiseHz = in7[(Index)i];//#map:_###_obj_###_:36
                __codebox_tilde_02_hitBodyLevel = in8[(Index)i];//#map:_###_obj_###_:37
                __codebox_tilde_02_hitNoiseLevel = in9[(Index)i];//#map:_###_obj_###_:38
                __codebox_tilde_02_hitNoiseQ = in10[(Index)i];//#map:_###_obj_###_:39
                __codebox_tilde_02_hitSnap = in11[(Index)i];//#map:_###_obj_###_:40
                __codebox_tilde_02_hitDrive = in12[(Index)i];//#map:_###_obj_###_:41
                __codebox_tilde_02_hitLevel = in13[(Index)i];//#map:_###_obj_###_:42
                __codebox_tilde_02_bodyEnv = 1;//#map:_###_obj_###_:43
                __codebox_tilde_02_noiseEnv = 1;//#map:_###_obj_###_:44
                __codebox_tilde_02_bendEnv = 1;//#map:_###_obj_###_:45
                __codebox_tilde_02_snapEnv = 1;//#map:_###_obj_###_:46
                __codebox_tilde_02_bodyPhase = 0;//#map:_###_obj_###_:47
                __codebox_tilde_02_modePhase = 0;//#map:_###_obj_###_:48
                __codebox_tilde_02_modPhase = 0;//#map:_###_obj_###_:49
                __codebox_tilde_02_svfIc1 = 0;//#map:_###_obj_###_:50
                __codebox_tilde_02_svfIc2 = 0;//#map:_###_obj_###_:51
            }//#map:_###_obj_###_:30
    
            number bodyCoef = rnbo_exp(
                (this->maximum(5, __codebox_tilde_02_hitBodyDecay) * 0.001 * sr == 0. ? 0. : -6.907755 / (this->maximum(5, __codebox_tilde_02_hitBodyDecay) * 0.001 * sr))
            );
    
            number noiseCoef = rnbo_exp(
                (this->maximum(5, __codebox_tilde_02_hitNoiseDecay) * 0.001 * sr == 0. ? 0. : -6.907755 / (this->maximum(5, __codebox_tilde_02_hitNoiseDecay) * 0.001 * sr))
            );
    
            __codebox_tilde_02_bodyEnv *= bodyCoef;//#map:_###_obj_###_:58
            __codebox_tilde_02_noiseEnv *= noiseCoef;//#map:_###_obj_###_:59
            __codebox_tilde_02_bendEnv *= bendCoef;//#map:_###_obj_###_:60
            __codebox_tilde_02_snapEnv *= snapCoef;//#map:_###_obj_###_:61
            number bodyHz = this->maximum(20, __codebox_tilde_02_hitBodyHz) + this->maximum(0, __codebox_tilde_02_hitBodyBend) * __codebox_tilde_02_bendEnv;
    
            __codebox_tilde_02_modPhase = this->wrap(
                __codebox_tilde_02_modPhase + ((sr == 0. ? 0. : bodyHz * 1.61803399 / sr)),
                0,
                1
            );//#map:_###_obj_###_:64
    
            number bodyFM = rnbo_sin(__codebox_tilde_02_modPhase * 6.283185307179586) * bodyHz * this->maximum(0, __codebox_tilde_02_hitBodyFM) * __codebox_tilde_02_bodyEnv;
            number bodyFreq = (bodyHz + bodyFM > sr * 0.45 ? sr * 0.45 : (bodyHz + bodyFM < 10 ? 10 : bodyHz + bodyFM));
            __codebox_tilde_02_bodyPhase = this->wrap(__codebox_tilde_02_bodyPhase + ((sr == 0. ? 0. : bodyFreq / sr)), 0, 1);//#map:_###_obj_###_:67
    
            __codebox_tilde_02_modePhase = this->wrap(
                __codebox_tilde_02_modePhase + ((sr == 0. ? 0. : bodyFreq * 1.472 / sr)),
                0,
                1
            );//#map:_###_obj_###_:68
    
            number body = (rnbo_sin(__codebox_tilde_02_bodyPhase * 6.283185307179586) + 0.32 * rnbo_sin(__codebox_tilde_02_modePhase * 6.283185307179586)) * __codebox_tilde_02_bodyEnv;
            __codebox_tilde_02_noiseState = this->wrap(__codebox_tilde_02_noiseState * 1.324717957 + 0.1234567, 0, 1);//#map:_###_obj_###_:73
            number white = __codebox_tilde_02_noiseState * 2 - 1;
            number filterHz = (__codebox_tilde_02_hitNoiseHz > sr * 0.45 ? sr * 0.45 : (__codebox_tilde_02_hitNoiseHz < 40 ? 40 : __codebox_tilde_02_hitNoiseHz));
            number g = rnbo_tan((sr == 0. ? 0. : 3.141592653589793 * filterHz / sr));
            number k = (this->maximum(0.5, __codebox_tilde_02_hitNoiseQ) == 0. ? 0. : (number)1 / this->maximum(0.5, __codebox_tilde_02_hitNoiseQ));
            number a1 = (1 + g * (g + k) == 0. ? 0. : (number)1 / (1 + g * (g + k)));
            number a2 = g * a1;
            number a3 = g * a2;
            number v3 = white - __codebox_tilde_02_svfIc2;
            number band = a1 * __codebox_tilde_02_svfIc1 + a2 * v3;
            number low = __codebox_tilde_02_svfIc2 + a2 * __codebox_tilde_02_svfIc1 + a3 * v3;
            __codebox_tilde_02_svfIc1 = 2 * band - __codebox_tilde_02_svfIc1;//#map:_###_obj_###_:84
            __codebox_tilde_02_svfIc2 = 2 * low - __codebox_tilde_02_svfIc2;//#map:_###_obj_###_:85
            number high = white - k * band - low;
            number snap = (__codebox_tilde_02_hitSnap > 1 ? 1 : (__codebox_tilde_02_hitSnap < 0 ? 0 : __codebox_tilde_02_hitSnap));
            number wires = band * 2.4 * __codebox_tilde_02_noiseEnv;
            number attack = high * 0.9 * __codebox_tilde_02_snapEnv + trig * 0.12;
            number raw = body * ((__codebox_tilde_02_hitBodyLevel > 1 ? 1 : (__codebox_tilde_02_hitBodyLevel < 0 ? 0 : __codebox_tilde_02_hitBodyLevel))) + (wires * (1 - snap * 0.25) + attack * snap) * ((__codebox_tilde_02_hitNoiseLevel > 1 ? 1 : (__codebox_tilde_02_hitNoiseLevel < 0 ? 0 : __codebox_tilde_02_hitNoiseLevel)));
            auto drive = this->maximum(0.01, __codebox_tilde_02_hitDrive);
            out1[(Index)i] = ((rnbo_tanh(drive) == 0. ? 0. : rnbo_tanh(raw * drive) / rnbo_tanh(drive))) * ((__codebox_tilde_02_hitLevel > 1 ? 1 : (__codebox_tilde_02_hitLevel < 0 ? 0 : __codebox_tilde_02_hitLevel)));//#map:_###_obj_###_:94
        }
    
        this->codebox_tilde_02_hitBodyHz = __codebox_tilde_02_hitBodyHz;
        this->codebox_tilde_02_hitBodyBend = __codebox_tilde_02_hitBodyBend;
        this->codebox_tilde_02_hitNoiseDecay = __codebox_tilde_02_hitNoiseDecay;
        this->codebox_tilde_02_hitBodyDecay = __codebox_tilde_02_hitBodyDecay;
        this->codebox_tilde_02_hitBodyFM = __codebox_tilde_02_hitBodyFM;
        this->codebox_tilde_02_hitNoiseHz = __codebox_tilde_02_hitNoiseHz;
        this->codebox_tilde_02_hitBodyLevel = __codebox_tilde_02_hitBodyLevel;
        this->codebox_tilde_02_hitNoiseLevel = __codebox_tilde_02_hitNoiseLevel;
        this->codebox_tilde_02_hitNoiseQ = __codebox_tilde_02_hitNoiseQ;
        this->codebox_tilde_02_hitSnap = __codebox_tilde_02_hitSnap;
        this->codebox_tilde_02_hitDrive = __codebox_tilde_02_hitDrive;
        this->codebox_tilde_02_hitLevel = __codebox_tilde_02_hitLevel;
        this->codebox_tilde_02_bodyEnv = __codebox_tilde_02_bodyEnv;
        this->codebox_tilde_02_noiseEnv = __codebox_tilde_02_noiseEnv;
        this->codebox_tilde_02_bendEnv = __codebox_tilde_02_bendEnv;
        this->codebox_tilde_02_snapEnv = __codebox_tilde_02_snapEnv;
        this->codebox_tilde_02_bodyPhase = __codebox_tilde_02_bodyPhase;
        this->codebox_tilde_02_modePhase = __codebox_tilde_02_modePhase;
        this->codebox_tilde_02_modPhase = __codebox_tilde_02_modPhase;
        this->codebox_tilde_02_svfIc1 = __codebox_tilde_02_svfIc1;
        this->codebox_tilde_02_svfIc2 = __codebox_tilde_02_svfIc2;
        this->codebox_tilde_02_noiseState = __codebox_tilde_02_noiseState;
    }
    
    void dspexpr_02_perform(const Sample * in1, number in2, SampleValue * out1, Index n) {
        RNBO_UNUSED(in2);
        Index i;
    
        for (i = 0; i < (Index)n; i++) {
            out1[(Index)i] = in1[(Index)i] * 1;//#map:_###_obj_###_:1
        }
    }
    
    void signalforwarder_03_perform(const SampleValue * input, SampleValue * output, Index n) {
        copySignal(output, input, n);
    }
    
    void signalforwarder_04_perform(const SampleValue * input, SampleValue * output, Index n) {
        copySignal(output, input, n);
    }
    
    void stackprotect_perform(Index n) {
        RNBO_UNUSED(n);
        auto __stackprotect_count = this->stackprotect_count;
        __stackprotect_count = 0;
        this->stackprotect_count = __stackprotect_count;
    }
    
    void ip_13_init() {
        this->ip_13_lastValue = this->ip_13_value;
    }
    
    void ip_13_fillSigBuf() {
        if ((bool)(this->ip_13_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_13_lastIndex); i < k; i++) {
                if (this->ip_13_resetCount > 0) {
                    this->ip_13_sigbuf[(Index)i] = 1;
                    this->ip_13_resetCount--;
                } else {
                    this->ip_13_sigbuf[(Index)i] = this->ip_13_lastValue;
                }
            }
    
            this->ip_13_lastIndex = k;
        }
    }
    
    void ip_13_dspsetup(bool force) {
        if ((bool)(this->ip_13_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_13_lastIndex = 0;
        this->ip_13_setupDone = true;
    }
    
    void ip_14_init() {
        this->ip_14_lastValue = this->ip_14_value;
    }
    
    void ip_14_fillSigBuf() {
        if ((bool)(this->ip_14_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_14_lastIndex); i < k; i++) {
                if (this->ip_14_resetCount > 0) {
                    this->ip_14_sigbuf[(Index)i] = 1;
                    this->ip_14_resetCount--;
                } else {
                    this->ip_14_sigbuf[(Index)i] = this->ip_14_lastValue;
                }
            }
    
            this->ip_14_lastIndex = k;
        }
    }
    
    void ip_14_dspsetup(bool force) {
        if ((bool)(this->ip_14_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_14_lastIndex = 0;
        this->ip_14_setupDone = true;
    }
    
    void ip_15_init() {
        this->ip_15_lastValue = this->ip_15_value;
    }
    
    void ip_15_fillSigBuf() {
        if ((bool)(this->ip_15_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_15_lastIndex); i < k; i++) {
                if (this->ip_15_resetCount > 0) {
                    this->ip_15_sigbuf[(Index)i] = 1;
                    this->ip_15_resetCount--;
                } else {
                    this->ip_15_sigbuf[(Index)i] = this->ip_15_lastValue;
                }
            }
    
            this->ip_15_lastIndex = k;
        }
    }
    
    void ip_15_dspsetup(bool force) {
        if ((bool)(this->ip_15_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_15_lastIndex = 0;
        this->ip_15_setupDone = true;
    }
    
    void ip_16_init() {
        this->ip_16_lastValue = this->ip_16_value;
    }
    
    void ip_16_fillSigBuf() {
        if ((bool)(this->ip_16_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_16_lastIndex); i < k; i++) {
                if (this->ip_16_resetCount > 0) {
                    this->ip_16_sigbuf[(Index)i] = 1;
                    this->ip_16_resetCount--;
                } else {
                    this->ip_16_sigbuf[(Index)i] = this->ip_16_lastValue;
                }
            }
    
            this->ip_16_lastIndex = k;
        }
    }
    
    void ip_16_dspsetup(bool force) {
        if ((bool)(this->ip_16_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_16_lastIndex = 0;
        this->ip_16_setupDone = true;
    }
    
    void ip_17_init() {
        this->ip_17_lastValue = this->ip_17_value;
    }
    
    void ip_17_fillSigBuf() {
        if ((bool)(this->ip_17_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_17_lastIndex); i < k; i++) {
                if (this->ip_17_resetCount > 0) {
                    this->ip_17_sigbuf[(Index)i] = 1;
                    this->ip_17_resetCount--;
                } else {
                    this->ip_17_sigbuf[(Index)i] = this->ip_17_lastValue;
                }
            }
    
            this->ip_17_lastIndex = k;
        }
    }
    
    void ip_17_dspsetup(bool force) {
        if ((bool)(this->ip_17_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_17_lastIndex = 0;
        this->ip_17_setupDone = true;
    }
    
    void ip_18_init() {
        this->ip_18_lastValue = this->ip_18_value;
    }
    
    void ip_18_fillSigBuf() {
        if ((bool)(this->ip_18_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_18_lastIndex); i < k; i++) {
                if (this->ip_18_resetCount > 0) {
                    this->ip_18_sigbuf[(Index)i] = 1;
                    this->ip_18_resetCount--;
                } else {
                    this->ip_18_sigbuf[(Index)i] = this->ip_18_lastValue;
                }
            }
    
            this->ip_18_lastIndex = k;
        }
    }
    
    void ip_18_dspsetup(bool force) {
        if ((bool)(this->ip_18_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_18_lastIndex = 0;
        this->ip_18_setupDone = true;
    }
    
    void ip_19_init() {
        this->ip_19_lastValue = this->ip_19_value;
    }
    
    void ip_19_fillSigBuf() {
        if ((bool)(this->ip_19_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_19_lastIndex); i < k; i++) {
                if (this->ip_19_resetCount > 0) {
                    this->ip_19_sigbuf[(Index)i] = 1;
                    this->ip_19_resetCount--;
                } else {
                    this->ip_19_sigbuf[(Index)i] = this->ip_19_lastValue;
                }
            }
    
            this->ip_19_lastIndex = k;
        }
    }
    
    void ip_19_dspsetup(bool force) {
        if ((bool)(this->ip_19_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_19_lastIndex = 0;
        this->ip_19_setupDone = true;
    }
    
    void ip_20_init() {
        this->ip_20_lastValue = this->ip_20_value;
    }
    
    void ip_20_fillSigBuf() {
        if ((bool)(this->ip_20_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_20_lastIndex); i < k; i++) {
                if (this->ip_20_resetCount > 0) {
                    this->ip_20_sigbuf[(Index)i] = 1;
                    this->ip_20_resetCount--;
                } else {
                    this->ip_20_sigbuf[(Index)i] = this->ip_20_lastValue;
                }
            }
    
            this->ip_20_lastIndex = k;
        }
    }
    
    void ip_20_dspsetup(bool force) {
        if ((bool)(this->ip_20_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_20_lastIndex = 0;
        this->ip_20_setupDone = true;
    }
    
    void ip_21_init() {
        this->ip_21_lastValue = this->ip_21_value;
    }
    
    void ip_21_fillSigBuf() {
        if ((bool)(this->ip_21_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_21_lastIndex); i < k; i++) {
                if (this->ip_21_resetCount > 0) {
                    this->ip_21_sigbuf[(Index)i] = 1;
                    this->ip_21_resetCount--;
                } else {
                    this->ip_21_sigbuf[(Index)i] = this->ip_21_lastValue;
                }
            }
    
            this->ip_21_lastIndex = k;
        }
    }
    
    void ip_21_dspsetup(bool force) {
        if ((bool)(this->ip_21_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_21_lastIndex = 0;
        this->ip_21_setupDone = true;
    }
    
    void ip_22_init() {
        this->ip_22_lastValue = this->ip_22_value;
    }
    
    void ip_22_fillSigBuf() {
        if ((bool)(this->ip_22_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_22_lastIndex); i < k; i++) {
                if (this->ip_22_resetCount > 0) {
                    this->ip_22_sigbuf[(Index)i] = 1;
                    this->ip_22_resetCount--;
                } else {
                    this->ip_22_sigbuf[(Index)i] = this->ip_22_lastValue;
                }
            }
    
            this->ip_22_lastIndex = k;
        }
    }
    
    void ip_22_dspsetup(bool force) {
        if ((bool)(this->ip_22_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_22_lastIndex = 0;
        this->ip_22_setupDone = true;
    }
    
    void ip_23_init() {
        this->ip_23_lastValue = this->ip_23_value;
    }
    
    void ip_23_fillSigBuf() {
        if ((bool)(this->ip_23_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_23_lastIndex); i < k; i++) {
                if (this->ip_23_resetCount > 0) {
                    this->ip_23_sigbuf[(Index)i] = 1;
                    this->ip_23_resetCount--;
                } else {
                    this->ip_23_sigbuf[(Index)i] = this->ip_23_lastValue;
                }
            }
    
            this->ip_23_lastIndex = k;
        }
    }
    
    void ip_23_dspsetup(bool force) {
        if ((bool)(this->ip_23_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_23_lastIndex = 0;
        this->ip_23_setupDone = true;
    }
    
    void ip_24_init() {
        this->ip_24_lastValue = this->ip_24_value;
    }
    
    void ip_24_fillSigBuf() {
        if ((bool)(this->ip_24_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_24_lastIndex); i < k; i++) {
                if (this->ip_24_resetCount > 0) {
                    this->ip_24_sigbuf[(Index)i] = 1;
                    this->ip_24_resetCount--;
                } else {
                    this->ip_24_sigbuf[(Index)i] = this->ip_24_lastValue;
                }
            }
    
            this->ip_24_lastIndex = k;
        }
    }
    
    void ip_24_dspsetup(bool force) {
        if ((bool)(this->ip_24_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_24_lastIndex = 0;
        this->ip_24_setupDone = true;
    }
    
    bool stackprotect_check() {
        this->stackprotect_count++;
    
        if (this->stackprotect_count > 128) {
            console->log("STACK OVERFLOW DETECTED - stopped processing branch !");
            return true;
        }
    
        return false;
    }
    
    Index getPatcherSerial() const {
        return 0;
    }
    
    void sendParameter(ParameterIndex index, bool ignoreValue) {
        this->getPatcher()->sendParameter(index + this->parameterOffset, ignoreValue);
    }
    
    void scheduleParamInit(ParameterIndex index, Index order) {
        this->getPatcher()->scheduleParamInit(index + this->parameterOffset, order);
    }
    
    void updateTime(MillisecondTime time, EXTERNALENGINE* engine, bool inProcess = false) {
        RNBO_UNUSED(inProcess);
        RNBO_UNUSED(engine);
        this->_currentTime = time;
        auto offset = rnbo_fround(this->msToSamps(time - this->getEngine()->getCurrentTime(), this->sr));
    
        if (offset >= (SampleIndex)(this->vs))
            offset = (SampleIndex)(this->vs) - 1;
    
        if (offset < 0)
            offset = 0;
    
        this->sampleOffsetIntoNextAudioBuffer = (Index)(offset);
    }
    
    void assign_defaults()
    {
        ip_13_value = 0;
        ip_13_impulse = 0;
        ip_14_value = 0;
        ip_14_impulse = 0;
        ip_15_value = 0;
        ip_15_impulse = 0;
        ip_16_value = 0;
        ip_16_impulse = 0;
        ip_17_value = 0;
        ip_17_impulse = 0;
        ip_18_value = 0;
        ip_18_impulse = 0;
        ip_19_value = 0;
        ip_19_impulse = 0;
        ip_20_value = 0;
        ip_20_impulse = 0;
        ip_21_value = 0;
        ip_21_impulse = 0;
        ip_22_value = 0;
        ip_22_impulse = 0;
        ip_23_value = 0;
        ip_23_impulse = 0;
        ip_24_value = 0;
        ip_24_impulse = 0;
        codebox_tilde_02_in1 = 0;
        codebox_tilde_02_in2 = 0;
        codebox_tilde_02_in3 = 0;
        codebox_tilde_02_in4 = 0;
        codebox_tilde_02_in5 = 0;
        codebox_tilde_02_in6 = 0;
        codebox_tilde_02_in7 = 0;
        codebox_tilde_02_in8 = 0;
        codebox_tilde_02_in9 = 0;
        codebox_tilde_02_in10 = 0;
        codebox_tilde_02_in11 = 0;
        codebox_tilde_02_in12 = 0;
        codebox_tilde_02_in13 = 0;
        dspexpr_02_in1 = 0;
        dspexpr_02_in2 = 1;
        _currentTime = 0;
        audioProcessSampleCount = 0;
        sampleOffsetIntoNextAudioBuffer = 0;
        zeroBuffer = nullptr;
        dummyBuffer = nullptr;
        signals[0] = nullptr;
        signals[1] = nullptr;
        signals[2] = nullptr;
        signals[3] = nullptr;
        signals[4] = nullptr;
        signals[5] = nullptr;
        signals[6] = nullptr;
        signals[7] = nullptr;
        signals[8] = nullptr;
        signals[9] = nullptr;
        signals[10] = nullptr;
        signals[11] = nullptr;
        signals[12] = nullptr;
        signals[13] = nullptr;
        didAllocateSignals = 0;
        vs = 0;
        maxvs = 0;
        sr = 44100;
        invsr = 0.000022675736961451248;
        click_02_lastclick = -1;
        click_02_buf = nullptr;
        ip_13_lastIndex = 0;
        ip_13_lastValue = 0;
        ip_13_resetCount = 0;
        ip_13_sigbuf = nullptr;
        ip_13_setupDone = false;
        ip_14_lastIndex = 0;
        ip_14_lastValue = 0;
        ip_14_resetCount = 0;
        ip_14_sigbuf = nullptr;
        ip_14_setupDone = false;
        ip_15_lastIndex = 0;
        ip_15_lastValue = 0;
        ip_15_resetCount = 0;
        ip_15_sigbuf = nullptr;
        ip_15_setupDone = false;
        ip_16_lastIndex = 0;
        ip_16_lastValue = 0;
        ip_16_resetCount = 0;
        ip_16_sigbuf = nullptr;
        ip_16_setupDone = false;
        ip_17_lastIndex = 0;
        ip_17_lastValue = 0;
        ip_17_resetCount = 0;
        ip_17_sigbuf = nullptr;
        ip_17_setupDone = false;
        ip_18_lastIndex = 0;
        ip_18_lastValue = 0;
        ip_18_resetCount = 0;
        ip_18_sigbuf = nullptr;
        ip_18_setupDone = false;
        ip_19_lastIndex = 0;
        ip_19_lastValue = 0;
        ip_19_resetCount = 0;
        ip_19_sigbuf = nullptr;
        ip_19_setupDone = false;
        ip_20_lastIndex = 0;
        ip_20_lastValue = 0;
        ip_20_resetCount = 0;
        ip_20_sigbuf = nullptr;
        ip_20_setupDone = false;
        ip_21_lastIndex = 0;
        ip_21_lastValue = 0;
        ip_21_resetCount = 0;
        ip_21_sigbuf = nullptr;
        ip_21_setupDone = false;
        ip_22_lastIndex = 0;
        ip_22_lastValue = 0;
        ip_22_resetCount = 0;
        ip_22_sigbuf = nullptr;
        ip_22_setupDone = false;
        ip_23_lastIndex = 0;
        ip_23_lastValue = 0;
        ip_23_resetCount = 0;
        ip_23_sigbuf = nullptr;
        ip_23_setupDone = false;
        ip_24_lastIndex = 0;
        ip_24_lastValue = 0;
        ip_24_resetCount = 0;
        ip_24_sigbuf = nullptr;
        ip_24_setupDone = false;
        codebox_tilde_02_hitBodyHz = 180;
        codebox_tilde_02_hitBodyDecay = 180;
        codebox_tilde_02_hitBodyBend = 90;
        codebox_tilde_02_hitBodyFM = 0.35;
        codebox_tilde_02_hitNoiseDecay = 260;
        codebox_tilde_02_hitNoiseHz = 3500;
        codebox_tilde_02_hitNoiseQ = 1.1;
        codebox_tilde_02_hitSnap = 0.45;
        codebox_tilde_02_hitBodyLevel = 0.65;
        codebox_tilde_02_hitNoiseLevel = 0.72;
        codebox_tilde_02_hitDrive = 1.7;
        codebox_tilde_02_hitLevel = 0.45;
        codebox_tilde_02_bodyEnv = 0;
        codebox_tilde_02_noiseEnv = 0;
        codebox_tilde_02_bendEnv = 0;
        codebox_tilde_02_snapEnv = 0;
        codebox_tilde_02_bodyPhase = 0;
        codebox_tilde_02_modePhase = 0;
        codebox_tilde_02_modPhase = 0;
        codebox_tilde_02_noiseState = 0.17320508;
        codebox_tilde_02_svfIc1 = 0;
        codebox_tilde_02_svfIc2 = 0;
        stackprotect_count = 0;
        _voiceIndex = 0;
        _noteNumber = 0;
        isMuted = 1;
        parameterOffset = 0;
    }
    
    // member variables
    
        number ip_13_value;
        number ip_13_impulse;
        number ip_14_value;
        number ip_14_impulse;
        number ip_15_value;
        number ip_15_impulse;
        number ip_16_value;
        number ip_16_impulse;
        number ip_17_value;
        number ip_17_impulse;
        number ip_18_value;
        number ip_18_impulse;
        number ip_19_value;
        number ip_19_impulse;
        number ip_20_value;
        number ip_20_impulse;
        number ip_21_value;
        number ip_21_impulse;
        number ip_22_value;
        number ip_22_impulse;
        number ip_23_value;
        number ip_23_impulse;
        number ip_24_value;
        number ip_24_impulse;
        number codebox_tilde_02_in1;
        number codebox_tilde_02_in2;
        number codebox_tilde_02_in3;
        number codebox_tilde_02_in4;
        number codebox_tilde_02_in5;
        number codebox_tilde_02_in6;
        number codebox_tilde_02_in7;
        number codebox_tilde_02_in8;
        number codebox_tilde_02_in9;
        number codebox_tilde_02_in10;
        number codebox_tilde_02_in11;
        number codebox_tilde_02_in12;
        number codebox_tilde_02_in13;
        number dspexpr_02_in1;
        number dspexpr_02_in2;
        MillisecondTime _currentTime;
        UInt64 audioProcessSampleCount;
        Index sampleOffsetIntoNextAudioBuffer;
        signal zeroBuffer;
        signal dummyBuffer;
        SampleValue * signals[14];
        bool didAllocateSignals;
        Index vs;
        Index maxvs;
        number sr;
        number invsr;
        SampleIndex click_02_lastclick;
        signal click_02_buf;
        SampleIndex ip_13_lastIndex;
        number ip_13_lastValue;
        SampleIndex ip_13_resetCount;
        signal ip_13_sigbuf;
        bool ip_13_setupDone;
        SampleIndex ip_14_lastIndex;
        number ip_14_lastValue;
        SampleIndex ip_14_resetCount;
        signal ip_14_sigbuf;
        bool ip_14_setupDone;
        SampleIndex ip_15_lastIndex;
        number ip_15_lastValue;
        SampleIndex ip_15_resetCount;
        signal ip_15_sigbuf;
        bool ip_15_setupDone;
        SampleIndex ip_16_lastIndex;
        number ip_16_lastValue;
        SampleIndex ip_16_resetCount;
        signal ip_16_sigbuf;
        bool ip_16_setupDone;
        SampleIndex ip_17_lastIndex;
        number ip_17_lastValue;
        SampleIndex ip_17_resetCount;
        signal ip_17_sigbuf;
        bool ip_17_setupDone;
        SampleIndex ip_18_lastIndex;
        number ip_18_lastValue;
        SampleIndex ip_18_resetCount;
        signal ip_18_sigbuf;
        bool ip_18_setupDone;
        SampleIndex ip_19_lastIndex;
        number ip_19_lastValue;
        SampleIndex ip_19_resetCount;
        signal ip_19_sigbuf;
        bool ip_19_setupDone;
        SampleIndex ip_20_lastIndex;
        number ip_20_lastValue;
        SampleIndex ip_20_resetCount;
        signal ip_20_sigbuf;
        bool ip_20_setupDone;
        SampleIndex ip_21_lastIndex;
        number ip_21_lastValue;
        SampleIndex ip_21_resetCount;
        signal ip_21_sigbuf;
        bool ip_21_setupDone;
        SampleIndex ip_22_lastIndex;
        number ip_22_lastValue;
        SampleIndex ip_22_resetCount;
        signal ip_22_sigbuf;
        bool ip_22_setupDone;
        SampleIndex ip_23_lastIndex;
        number ip_23_lastValue;
        SampleIndex ip_23_resetCount;
        signal ip_23_sigbuf;
        bool ip_23_setupDone;
        SampleIndex ip_24_lastIndex;
        number ip_24_lastValue;
        SampleIndex ip_24_resetCount;
        signal ip_24_sigbuf;
        bool ip_24_setupDone;
        number codebox_tilde_02_hitBodyHz;
        number codebox_tilde_02_hitBodyDecay;
        number codebox_tilde_02_hitBodyBend;
        number codebox_tilde_02_hitBodyFM;
        number codebox_tilde_02_hitNoiseDecay;
        number codebox_tilde_02_hitNoiseHz;
        number codebox_tilde_02_hitNoiseQ;
        number codebox_tilde_02_hitSnap;
        number codebox_tilde_02_hitBodyLevel;
        number codebox_tilde_02_hitNoiseLevel;
        number codebox_tilde_02_hitDrive;
        number codebox_tilde_02_hitLevel;
        number codebox_tilde_02_bodyEnv;
        number codebox_tilde_02_noiseEnv;
        number codebox_tilde_02_bendEnv;
        number codebox_tilde_02_snapEnv;
        number codebox_tilde_02_bodyPhase;
        number codebox_tilde_02_modePhase;
        number codebox_tilde_02_modPhase;
        number codebox_tilde_02_noiseState;
        number codebox_tilde_02_svfIc1;
        number codebox_tilde_02_svfIc2;
        number stackprotect_count;
        Index _voiceIndex;
        Int _noteNumber;
        Index isMuted;
        ParameterIndex parameterOffset;
        bool _isInitialized = false;
};

class RNBOSubpatcher_120 : public PatcherInterfaceImpl {
    
    friend class rnbomatic;
    
    public:
    
    RNBOSubpatcher_120()
    {}
    
    ~RNBOSubpatcher_120()
    {
        deallocateSignals();
    }
    
    Index getNumMidiInputPorts() const {
        return 0;
    }
    
    void processMidiEvent(MillisecondTime , int , ConstByteArray , Index ) {}
    
    Index getNumMidiOutputPorts() const {
        return 0;
    }
    
    void process(
        const SampleValue * const* inputs,
        Index numInputs,
        SampleValue * const* outputs,
        Index numOutputs,
        Index n
    ) {
        RNBO_UNUSED(numInputs);
        RNBO_UNUSED(inputs);
        this->vs = n;
        this->updateTime(this->getEngine()->getCurrentTime(), (ENGINE*)nullptr, true);
        SampleValue * out1 = (numOutputs >= 1 && outputs[0] ? outputs[0] : this->dummyBuffer);
        SampleValue * out2 = (numOutputs >= 2 && outputs[1] ? outputs[1] : this->dummyBuffer);
        this->click_03_perform(this->signals[0], n);
        this->ip_25_perform(this->signals[1], n);
        this->ip_26_perform(this->signals[2], n);
        this->ip_27_perform(this->signals[3], n);
        this->ip_28_perform(this->signals[4], n);
        this->ip_29_perform(this->signals[5], n);
        this->ip_30_perform(this->signals[6], n);
        this->ip_31_perform(this->signals[7], n);
        this->ip_32_perform(this->signals[8], n);
        this->ip_33_perform(this->signals[9], n);
        this->ip_34_perform(this->signals[10], n);
        this->ip_35_perform(this->signals[11], n);
        this->ip_36_perform(this->signals[12], n);
    
        this->codebox_tilde_03_perform(
            this->signals[0],
            this->signals[1],
            this->signals[2],
            this->signals[3],
            this->signals[4],
            this->signals[5],
            this->signals[6],
            this->signals[7],
            this->signals[8],
            this->signals[9],
            this->signals[10],
            this->signals[11],
            this->signals[12],
            this->signals[13],
            n
        );
    
        this->dspexpr_03_perform(this->signals[13], this->dspexpr_03_in2, this->signals[12], n);
        this->signalforwarder_05_perform(this->signals[12], out2, n);
        this->signalforwarder_06_perform(this->signals[12], out1, n);
        this->stackprotect_perform(n);
        this->audioProcessSampleCount += this->vs;
    }
    
    void prepareToProcess(number sampleRate, Index maxBlockSize, bool force) {
        RNBO_ASSERT(this->_isInitialized);
    
        if (this->maxvs < maxBlockSize || !this->didAllocateSignals) {
            Index i;
    
            for (i = 0; i < 14; i++) {
                this->signals[i] = resizeSignal(this->signals[i], this->maxvs, maxBlockSize);
            }
    
            this->click_03_buf = resizeSignal(this->click_03_buf, this->maxvs, maxBlockSize);
            this->ip_25_sigbuf = resizeSignal(this->ip_25_sigbuf, this->maxvs, maxBlockSize);
            this->ip_26_sigbuf = resizeSignal(this->ip_26_sigbuf, this->maxvs, maxBlockSize);
            this->ip_27_sigbuf = resizeSignal(this->ip_27_sigbuf, this->maxvs, maxBlockSize);
            this->ip_28_sigbuf = resizeSignal(this->ip_28_sigbuf, this->maxvs, maxBlockSize);
            this->ip_29_sigbuf = resizeSignal(this->ip_29_sigbuf, this->maxvs, maxBlockSize);
            this->ip_30_sigbuf = resizeSignal(this->ip_30_sigbuf, this->maxvs, maxBlockSize);
            this->ip_31_sigbuf = resizeSignal(this->ip_31_sigbuf, this->maxvs, maxBlockSize);
            this->ip_32_sigbuf = resizeSignal(this->ip_32_sigbuf, this->maxvs, maxBlockSize);
            this->ip_33_sigbuf = resizeSignal(this->ip_33_sigbuf, this->maxvs, maxBlockSize);
            this->ip_34_sigbuf = resizeSignal(this->ip_34_sigbuf, this->maxvs, maxBlockSize);
            this->ip_35_sigbuf = resizeSignal(this->ip_35_sigbuf, this->maxvs, maxBlockSize);
            this->ip_36_sigbuf = resizeSignal(this->ip_36_sigbuf, this->maxvs, maxBlockSize);
            this->zeroBuffer = resizeSignal(this->zeroBuffer, this->maxvs, maxBlockSize);
            this->dummyBuffer = resizeSignal(this->dummyBuffer, this->maxvs, maxBlockSize);
            this->didAllocateSignals = true;
        }
    
        const bool sampleRateChanged = sampleRate != this->sr;
        const bool maxvsChanged = maxBlockSize != this->maxvs;
        const bool forceDSPSetup = sampleRateChanged || maxvsChanged || force;
    
        if (sampleRateChanged || maxvsChanged) {
            this->vs = maxBlockSize;
            this->maxvs = maxBlockSize;
            this->sr = sampleRate;
            this->invsr = 1 / sampleRate;
        }
    
        this->ip_25_dspsetup(forceDSPSetup);
        this->ip_26_dspsetup(forceDSPSetup);
        this->ip_27_dspsetup(forceDSPSetup);
        this->ip_28_dspsetup(forceDSPSetup);
        this->ip_29_dspsetup(forceDSPSetup);
        this->ip_30_dspsetup(forceDSPSetup);
        this->ip_31_dspsetup(forceDSPSetup);
        this->ip_32_dspsetup(forceDSPSetup);
        this->ip_33_dspsetup(forceDSPSetup);
        this->ip_34_dspsetup(forceDSPSetup);
        this->ip_35_dspsetup(forceDSPSetup);
        this->ip_36_dspsetup(forceDSPSetup);
    
        if (sampleRateChanged)
            this->onSampleRateChanged(sampleRate);
    }
    
    number msToSamps(MillisecondTime ms, number sampleRate) {
        return ms * sampleRate * 0.001;
    }
    
    MillisecondTime sampsToMs(SampleIndex samps) {
        return samps * (this->invsr * 1000);
    }
    
    Index getNumInputChannels() const {
        return 0;
    }
    
    Index getNumOutputChannels() const {
        return 2;
    }
    
    void getPreset(PatcherStateInterface& ) {}
    
    void setPreset(MillisecondTime , PatcherStateInterface& ) {}
    
    void setParameterValue(ParameterIndex , ParameterValue , MillisecondTime ) {}
    
    void processParameterEvent(ParameterIndex index, ParameterValue value, MillisecondTime time) {
        this->setParameterValue(index, value, time);
    }
    
    void processParameterBangEvent(ParameterIndex index, MillisecondTime time) {
        this->setParameterValue(index, this->getParameterValue(index), time);
    }
    
    void processNormalizedParameterEvent(ParameterIndex index, ParameterValue value, MillisecondTime time) {
        this->setParameterValueNormalized(index, value, time);
    }
    
    ParameterValue getParameterValue(ParameterIndex index)  {
        switch (index) {
        default:
            {
            return 0;
            }
        }
    }
    
    ParameterIndex getNumSignalInParameters() const {
        return 0;
    }
    
    ParameterIndex getNumSignalOutParameters() const {
        return 0;
    }
    
    ParameterIndex getNumParameters() const {
        return 0;
    }
    
    ConstCharPointer getParameterName(ParameterIndex index) const {
        switch (index) {
        default:
            {
            return "bogus";
            }
        }
    }
    
    ConstCharPointer getParameterId(ParameterIndex index) const {
        switch (index) {
        default:
            {
            return "bogus";
            }
        }
    }
    
    void getParameterInfo(ParameterIndex , ParameterInfo * ) const {}
    
    ParameterValue applyStepsToNormalizedParameterValue(ParameterValue normalizedValue, int steps) const {
        if (steps == 1) {
            if (normalizedValue > 0) {
                normalizedValue = 1.;
            }
        } else {
            ParameterValue oneStep = (number)1. / (steps - 1);
            ParameterValue numberOfSteps = rnbo_fround(normalizedValue / oneStep * 1 / (number)1) * (number)1;
            normalizedValue = numberOfSteps * oneStep;
        }
    
        return normalizedValue;
    }
    
    ParameterValue convertToNormalizedParameterValue(ParameterIndex index, ParameterValue value) const {
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    ParameterValue convertFromNormalizedParameterValue(ParameterIndex index, ParameterValue value) const {
        value = (value < 0 ? 0 : (value > 1 ? 1 : value));
    
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    ParameterValue constrainParameterValue(ParameterIndex index, ParameterValue value) const {
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    void processNumMessage(MessageTag , MessageTag , MillisecondTime , number ) {}
    
    void processListMessage(MessageTag , MessageTag , MillisecondTime , const list& ) {}
    
    void processBangMessage(MessageTag , MessageTag , MillisecondTime ) {}
    
    MessageTagInfo resolveTag(MessageTag tag) const {
        switch (tag) {
    
        }
    
        return nullptr;
    }
    
    DataRef* getDataRef(DataRefIndex index)  {
        switch (index) {
        default:
            {
            return nullptr;
            }
        }
    }
    
    DataRefIndex getNumDataRefs() const {
        return 0;
    }
    
    void processDataViewUpdate(DataRefIndex , MillisecondTime ) {}
    
    void initialize() {
        RNBO_ASSERT(!this->_isInitialized);
        this->assign_defaults();
        this->applyState();
        this->_isInitialized = true;
    }
    
    protected:
    
    void updateTime(MillisecondTime time, INTERNALENGINE*, bool inProcess = false) {
    	if (time == TimeNow) time = getTopLevelPatcher()->getPatcherTime();
    	getTopLevelPatcher()->processInternalEvents(time);
    	updateTime(time, (EXTERNALENGINE*)nullptr);
    }
    
    RNBOSubpatcher_120* operator->() {
        return this;
    }
    const RNBOSubpatcher_120* operator->() const {
        return this;
    }
    virtual rnbomatic* getPatcher() const {
        return static_cast<rnbomatic *>(_parentPatcher);
    }
    
    rnbomatic* getTopLevelPatcher() {
        return this->getPatcher()->getTopLevelPatcher();
    }
    
    void cancelClockEvents()
    {
    }
    
    number maximum(number x, number y) {
        return (x < y ? y : x);
    }
    
    number wrap(number x, number low, number high) {
        number lo;
        number hi;
    
        if (low == high)
            return low;
    
        if (low > high) {
            hi = low;
            lo = high;
        } else {
            lo = low;
            hi = high;
        }
    
        number range = hi - lo;
    
        if (x >= lo && x < hi)
            return x;
    
        if (range <= 0.000000001)
            return lo;
    
        Int numWraps = (Int)(trunc((x - lo) / range));
        numWraps = numWraps - ((x < lo ? 1 : 0));
        number result = x - range * numWraps;
    
        if (result >= hi)
            return result - range;
        else
            return result;
    }
    
    number minimum(number x, number y) {
        return (y < x ? y : x);
    }
    
    MillisecondTime getPatcherTime() const {
        return this->_currentTime;
    }
    
    void eventinlet_28_out1_bang_bang() {
        this->ip_25_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_28_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_25_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_25_value_set(converted);
        }
    }
    
    void eventinlet_29_out1_bang_bang() {
        this->ip_26_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_29_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_26_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_26_value_set(converted);
        }
    }
    
    void eventinlet_30_out1_bang_bang() {
        this->ip_27_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_30_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_27_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_27_value_set(converted);
        }
    }
    
    void eventinlet_31_out1_bang_bang() {
        this->ip_28_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_31_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_28_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_28_value_set(converted);
        }
    }
    
    void eventinlet_32_out1_bang_bang() {
        this->ip_29_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_32_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_29_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_29_value_set(converted);
        }
    }
    
    void eventinlet_33_out1_bang_bang() {
        this->ip_30_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_33_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_30_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_30_value_set(converted);
        }
    }
    
    void eventinlet_34_out1_bang_bang() {
        this->ip_31_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_34_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_31_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_31_value_set(converted);
        }
    }
    
    void eventinlet_35_out1_bang_bang() {
        this->ip_32_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_35_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_32_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_32_value_set(converted);
        }
    }
    
    void eventinlet_36_out1_bang_bang() {
        this->ip_33_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_36_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_33_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_33_value_set(converted);
        }
    }
    
    void eventinlet_37_out1_bang_bang() {
        this->ip_34_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_37_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_34_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_34_value_set(converted);
        }
    }
    
    void eventinlet_38_out1_bang_bang() {
        this->ip_35_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_38_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_35_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_35_value_set(converted);
        }
    }
    
    void eventinlet_39_out1_bang_bang() {
        this->ip_36_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_39_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_36_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_36_value_set(converted);
        }
    }
    
    void deallocateSignals() {
        Index i;
    
        for (i = 0; i < 14; i++) {
            this->signals[i] = freeSignal(this->signals[i]);
        }
    
        this->click_03_buf = freeSignal(this->click_03_buf);
        this->ip_25_sigbuf = freeSignal(this->ip_25_sigbuf);
        this->ip_26_sigbuf = freeSignal(this->ip_26_sigbuf);
        this->ip_27_sigbuf = freeSignal(this->ip_27_sigbuf);
        this->ip_28_sigbuf = freeSignal(this->ip_28_sigbuf);
        this->ip_29_sigbuf = freeSignal(this->ip_29_sigbuf);
        this->ip_30_sigbuf = freeSignal(this->ip_30_sigbuf);
        this->ip_31_sigbuf = freeSignal(this->ip_31_sigbuf);
        this->ip_32_sigbuf = freeSignal(this->ip_32_sigbuf);
        this->ip_33_sigbuf = freeSignal(this->ip_33_sigbuf);
        this->ip_34_sigbuf = freeSignal(this->ip_34_sigbuf);
        this->ip_35_sigbuf = freeSignal(this->ip_35_sigbuf);
        this->ip_36_sigbuf = freeSignal(this->ip_36_sigbuf);
        this->zeroBuffer = freeSignal(this->zeroBuffer);
        this->dummyBuffer = freeSignal(this->dummyBuffer);
    }
    
    Index getMaxBlockSize() const {
        return this->maxvs;
    }
    
    number getSampleRate() const {
        return this->sr;
    }
    
    bool hasFixedVectorSize() const {
        return false;
    }
    
    void setProbingTarget(MessageTag ) {}
    
    void initializeObjects() {
        this->ip_25_init();
        this->ip_26_init();
        this->ip_27_init();
        this->ip_28_init();
        this->ip_29_init();
        this->ip_30_init();
        this->ip_31_init();
        this->ip_32_init();
        this->ip_33_init();
        this->ip_34_init();
        this->ip_35_init();
        this->ip_36_init();
    }
    
    Index getIsMuted()  {
        return this->isMuted;
    }
    
    void setIsMuted(Index v)  {
        this->isMuted = v;
    }
    
    void onSampleRateChanged(double ) {}
    
    void extractState(PatcherStateInterface& ) {}
    
    void applyState() {}
    
    void setParameterOffset(ParameterIndex offset) {
        this->parameterOffset = offset;
    }
    
    void processClockEvent(MillisecondTime , ClockId , bool , ParameterValue ) {}
    
    void processOutletAtCurrentTime(EngineLink* , OutletIndex , ParameterValue ) {}
    
    void processOutletEvent(
        EngineLink* sender,
        OutletIndex index,
        ParameterValue value,
        MillisecondTime time
    ) {
        this->updateTime(time, (ENGINE*)nullptr);
        this->processOutletAtCurrentTime(sender, index, value);
    }
    
    void sendOutlet(OutletIndex index, ParameterValue value) {
        this->getEngine()->sendOutlet(this, index, value);
    }
    
    void startup() {}
    
    void fillDataRef(DataRefIndex , DataRef& ) {}
    
    void allocateDataRefs() {}
    
    void ip_25_value_set(number v) {
        this->ip_25_value = v;
        this->ip_25_fillSigBuf();
        this->ip_25_lastValue = v;
    }
    
    void eventinlet_28_out1_number_set(number v) {
        this->ip_25_value_set(v);
    }
    
    void ip_26_value_set(number v) {
        this->ip_26_value = v;
        this->ip_26_fillSigBuf();
        this->ip_26_lastValue = v;
    }
    
    void eventinlet_29_out1_number_set(number v) {
        this->ip_26_value_set(v);
    }
    
    void ip_27_value_set(number v) {
        this->ip_27_value = v;
        this->ip_27_fillSigBuf();
        this->ip_27_lastValue = v;
    }
    
    void eventinlet_30_out1_number_set(number v) {
        this->ip_27_value_set(v);
    }
    
    void ip_28_value_set(number v) {
        this->ip_28_value = v;
        this->ip_28_fillSigBuf();
        this->ip_28_lastValue = v;
    }
    
    void eventinlet_31_out1_number_set(number v) {
        this->ip_28_value_set(v);
    }
    
    void ip_29_value_set(number v) {
        this->ip_29_value = v;
        this->ip_29_fillSigBuf();
        this->ip_29_lastValue = v;
    }
    
    void eventinlet_32_out1_number_set(number v) {
        this->ip_29_value_set(v);
    }
    
    void ip_30_value_set(number v) {
        this->ip_30_value = v;
        this->ip_30_fillSigBuf();
        this->ip_30_lastValue = v;
    }
    
    void eventinlet_33_out1_number_set(number v) {
        this->ip_30_value_set(v);
    }
    
    void ip_31_value_set(number v) {
        this->ip_31_value = v;
        this->ip_31_fillSigBuf();
        this->ip_31_lastValue = v;
    }
    
    void eventinlet_34_out1_number_set(number v) {
        this->ip_31_value_set(v);
    }
    
    void ip_32_value_set(number v) {
        this->ip_32_value = v;
        this->ip_32_fillSigBuf();
        this->ip_32_lastValue = v;
    }
    
    void eventinlet_35_out1_number_set(number v) {
        this->ip_32_value_set(v);
    }
    
    void ip_33_value_set(number v) {
        this->ip_33_value = v;
        this->ip_33_fillSigBuf();
        this->ip_33_lastValue = v;
    }
    
    void eventinlet_36_out1_number_set(number v) {
        this->ip_33_value_set(v);
    }
    
    void ip_34_value_set(number v) {
        this->ip_34_value = v;
        this->ip_34_fillSigBuf();
        this->ip_34_lastValue = v;
    }
    
    void eventinlet_37_out1_number_set(number v) {
        this->ip_34_value_set(v);
    }
    
    void ip_35_value_set(number v) {
        this->ip_35_value = v;
        this->ip_35_fillSigBuf();
        this->ip_35_lastValue = v;
    }
    
    void eventinlet_38_out1_number_set(number v) {
        this->ip_35_value_set(v);
    }
    
    void ip_36_value_set(number v) {
        this->ip_36_value = v;
        this->ip_36_fillSigBuf();
        this->ip_36_lastValue = v;
    }
    
    void eventinlet_39_out1_number_set(number v) {
        this->ip_36_value_set(v);
    }
    
    void click_03_click_number_set(number v) {
        for (SampleIndex i = (SampleIndex)(this->click_03_lastclick + 1); i < this->sampleOffsetIntoNextAudioBuffer; i++) {
            this->click_03_buf[(Index)i] = 0;
        }
    
        this->click_03_lastclick = this->sampleOffsetIntoNextAudioBuffer;
        this->click_03_buf[(Index)this->click_03_lastclick] = v;
    }
    
    void click_03_click_bang_bang() {
        this->click_03_click_number_set(1);
    }
    
    void eventinlet_27_out1_bang_bang() {
        this->click_03_click_bang_bang();
    }
    
    void eventinlet_27_out1_number_set(number v) {
        this->click_03_click_number_set(v);
    }
    
    template<typename LISTTYPE> void eventinlet_27_out1_list_set(const LISTTYPE& v) {
        {
            number converted = (v->length > 0 ? v[0] : 0);
            this->click_03_click_number_set(converted);
        }
    }
    
    void ip_25_value_bang() {
        number v = this->ip_25_value;
        this->ip_25_fillSigBuf();
        this->ip_25_lastValue = v;
    }
    
    void ip_25_impulse_set(number v) {
        this->ip_25_impulse = v;
        this->ip_25_fillSigBuf();
        this->ip_25_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_25_resetCount = lengthInSamples;
    }
    
    void ip_26_value_bang() {
        number v = this->ip_26_value;
        this->ip_26_fillSigBuf();
        this->ip_26_lastValue = v;
    }
    
    void ip_26_impulse_set(number v) {
        this->ip_26_impulse = v;
        this->ip_26_fillSigBuf();
        this->ip_26_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_26_resetCount = lengthInSamples;
    }
    
    void ip_27_value_bang() {
        number v = this->ip_27_value;
        this->ip_27_fillSigBuf();
        this->ip_27_lastValue = v;
    }
    
    void ip_27_impulse_set(number v) {
        this->ip_27_impulse = v;
        this->ip_27_fillSigBuf();
        this->ip_27_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_27_resetCount = lengthInSamples;
    }
    
    void ip_28_value_bang() {
        number v = this->ip_28_value;
        this->ip_28_fillSigBuf();
        this->ip_28_lastValue = v;
    }
    
    void ip_28_impulse_set(number v) {
        this->ip_28_impulse = v;
        this->ip_28_fillSigBuf();
        this->ip_28_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_28_resetCount = lengthInSamples;
    }
    
    void ip_29_value_bang() {
        number v = this->ip_29_value;
        this->ip_29_fillSigBuf();
        this->ip_29_lastValue = v;
    }
    
    void ip_29_impulse_set(number v) {
        this->ip_29_impulse = v;
        this->ip_29_fillSigBuf();
        this->ip_29_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_29_resetCount = lengthInSamples;
    }
    
    void ip_30_value_bang() {
        number v = this->ip_30_value;
        this->ip_30_fillSigBuf();
        this->ip_30_lastValue = v;
    }
    
    void ip_30_impulse_set(number v) {
        this->ip_30_impulse = v;
        this->ip_30_fillSigBuf();
        this->ip_30_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_30_resetCount = lengthInSamples;
    }
    
    void ip_31_value_bang() {
        number v = this->ip_31_value;
        this->ip_31_fillSigBuf();
        this->ip_31_lastValue = v;
    }
    
    void ip_31_impulse_set(number v) {
        this->ip_31_impulse = v;
        this->ip_31_fillSigBuf();
        this->ip_31_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_31_resetCount = lengthInSamples;
    }
    
    void ip_32_value_bang() {
        number v = this->ip_32_value;
        this->ip_32_fillSigBuf();
        this->ip_32_lastValue = v;
    }
    
    void ip_32_impulse_set(number v) {
        this->ip_32_impulse = v;
        this->ip_32_fillSigBuf();
        this->ip_32_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_32_resetCount = lengthInSamples;
    }
    
    void ip_33_value_bang() {
        number v = this->ip_33_value;
        this->ip_33_fillSigBuf();
        this->ip_33_lastValue = v;
    }
    
    void ip_33_impulse_set(number v) {
        this->ip_33_impulse = v;
        this->ip_33_fillSigBuf();
        this->ip_33_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_33_resetCount = lengthInSamples;
    }
    
    void ip_34_value_bang() {
        number v = this->ip_34_value;
        this->ip_34_fillSigBuf();
        this->ip_34_lastValue = v;
    }
    
    void ip_34_impulse_set(number v) {
        this->ip_34_impulse = v;
        this->ip_34_fillSigBuf();
        this->ip_34_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_34_resetCount = lengthInSamples;
    }
    
    void ip_35_value_bang() {
        number v = this->ip_35_value;
        this->ip_35_fillSigBuf();
        this->ip_35_lastValue = v;
    }
    
    void ip_35_impulse_set(number v) {
        this->ip_35_impulse = v;
        this->ip_35_fillSigBuf();
        this->ip_35_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_35_resetCount = lengthInSamples;
    }
    
    void ip_36_value_bang() {
        number v = this->ip_36_value;
        this->ip_36_fillSigBuf();
        this->ip_36_lastValue = v;
    }
    
    void ip_36_impulse_set(number v) {
        this->ip_36_impulse = v;
        this->ip_36_fillSigBuf();
        this->ip_36_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_36_resetCount = lengthInSamples;
    }
    
    void click_03_perform(SampleValue * out, Index n) {
        auto __click_03_lastclick = this->click_03_lastclick;
    
        for (SampleIndex i = 0; i <= __click_03_lastclick; i++) {
            out[(Index)i] = this->click_03_buf[(Index)i];
        }
    
        for (SampleIndex i = (SampleIndex)(__click_03_lastclick + 1); i < (SampleIndex)(n); i++) {
            out[(Index)i] = 0;
        }
    
        __click_03_lastclick = -1;
        this->click_03_lastclick = __click_03_lastclick;
    }
    
    void ip_25_perform(SampleValue * out, Index n) {
        auto __ip_25_lastValue = this->ip_25_lastValue;
        auto __ip_25_lastIndex = this->ip_25_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_25_lastIndex ? __ip_25_lastValue : this->ip_25_sigbuf[(Index)i]);
        }
    
        __ip_25_lastIndex = 0;
        this->ip_25_lastIndex = __ip_25_lastIndex;
    }
    
    void ip_26_perform(SampleValue * out, Index n) {
        auto __ip_26_lastValue = this->ip_26_lastValue;
        auto __ip_26_lastIndex = this->ip_26_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_26_lastIndex ? __ip_26_lastValue : this->ip_26_sigbuf[(Index)i]);
        }
    
        __ip_26_lastIndex = 0;
        this->ip_26_lastIndex = __ip_26_lastIndex;
    }
    
    void ip_27_perform(SampleValue * out, Index n) {
        auto __ip_27_lastValue = this->ip_27_lastValue;
        auto __ip_27_lastIndex = this->ip_27_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_27_lastIndex ? __ip_27_lastValue : this->ip_27_sigbuf[(Index)i]);
        }
    
        __ip_27_lastIndex = 0;
        this->ip_27_lastIndex = __ip_27_lastIndex;
    }
    
    void ip_28_perform(SampleValue * out, Index n) {
        auto __ip_28_lastValue = this->ip_28_lastValue;
        auto __ip_28_lastIndex = this->ip_28_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_28_lastIndex ? __ip_28_lastValue : this->ip_28_sigbuf[(Index)i]);
        }
    
        __ip_28_lastIndex = 0;
        this->ip_28_lastIndex = __ip_28_lastIndex;
    }
    
    void ip_29_perform(SampleValue * out, Index n) {
        auto __ip_29_lastValue = this->ip_29_lastValue;
        auto __ip_29_lastIndex = this->ip_29_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_29_lastIndex ? __ip_29_lastValue : this->ip_29_sigbuf[(Index)i]);
        }
    
        __ip_29_lastIndex = 0;
        this->ip_29_lastIndex = __ip_29_lastIndex;
    }
    
    void ip_30_perform(SampleValue * out, Index n) {
        auto __ip_30_lastValue = this->ip_30_lastValue;
        auto __ip_30_lastIndex = this->ip_30_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_30_lastIndex ? __ip_30_lastValue : this->ip_30_sigbuf[(Index)i]);
        }
    
        __ip_30_lastIndex = 0;
        this->ip_30_lastIndex = __ip_30_lastIndex;
    }
    
    void ip_31_perform(SampleValue * out, Index n) {
        auto __ip_31_lastValue = this->ip_31_lastValue;
        auto __ip_31_lastIndex = this->ip_31_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_31_lastIndex ? __ip_31_lastValue : this->ip_31_sigbuf[(Index)i]);
        }
    
        __ip_31_lastIndex = 0;
        this->ip_31_lastIndex = __ip_31_lastIndex;
    }
    
    void ip_32_perform(SampleValue * out, Index n) {
        auto __ip_32_lastValue = this->ip_32_lastValue;
        auto __ip_32_lastIndex = this->ip_32_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_32_lastIndex ? __ip_32_lastValue : this->ip_32_sigbuf[(Index)i]);
        }
    
        __ip_32_lastIndex = 0;
        this->ip_32_lastIndex = __ip_32_lastIndex;
    }
    
    void ip_33_perform(SampleValue * out, Index n) {
        auto __ip_33_lastValue = this->ip_33_lastValue;
        auto __ip_33_lastIndex = this->ip_33_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_33_lastIndex ? __ip_33_lastValue : this->ip_33_sigbuf[(Index)i]);
        }
    
        __ip_33_lastIndex = 0;
        this->ip_33_lastIndex = __ip_33_lastIndex;
    }
    
    void ip_34_perform(SampleValue * out, Index n) {
        auto __ip_34_lastValue = this->ip_34_lastValue;
        auto __ip_34_lastIndex = this->ip_34_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_34_lastIndex ? __ip_34_lastValue : this->ip_34_sigbuf[(Index)i]);
        }
    
        __ip_34_lastIndex = 0;
        this->ip_34_lastIndex = __ip_34_lastIndex;
    }
    
    void ip_35_perform(SampleValue * out, Index n) {
        auto __ip_35_lastValue = this->ip_35_lastValue;
        auto __ip_35_lastIndex = this->ip_35_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_35_lastIndex ? __ip_35_lastValue : this->ip_35_sigbuf[(Index)i]);
        }
    
        __ip_35_lastIndex = 0;
        this->ip_35_lastIndex = __ip_35_lastIndex;
    }
    
    void ip_36_perform(SampleValue * out, Index n) {
        auto __ip_36_lastValue = this->ip_36_lastValue;
        auto __ip_36_lastIndex = this->ip_36_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_36_lastIndex ? __ip_36_lastValue : this->ip_36_sigbuf[(Index)i]);
        }
    
        __ip_36_lastIndex = 0;
        this->ip_36_lastIndex = __ip_36_lastIndex;
    }
    
    void codebox_tilde_03_perform(
        const Sample * in1,
        const Sample * in2,
        const Sample * in3,
        const Sample * in4,
        const Sample * in5,
        const Sample * in6,
        const Sample * in7,
        const Sample * in8,
        const Sample * in9,
        const Sample * in10,
        const Sample * in11,
        const Sample * in12,
        const Sample * in13,
        SampleValue * out1,
        Index n
    ) {
        auto __codebox_tilde_03_noiseState = this->codebox_tilde_03_noiseState;
        auto __codebox_tilde_03_phase6 = this->codebox_tilde_03_phase6;
        auto __codebox_tilde_03_phase5 = this->codebox_tilde_03_phase5;
        auto __codebox_tilde_03_phase4 = this->codebox_tilde_03_phase4;
        auto __codebox_tilde_03_phase3 = this->codebox_tilde_03_phase3;
        auto __codebox_tilde_03_phase2 = this->codebox_tilde_03_phase2;
        auto __codebox_tilde_03_phase1 = this->codebox_tilde_03_phase1;
        auto __codebox_tilde_03_svfIc2 = this->codebox_tilde_03_svfIc2;
        auto __codebox_tilde_03_svfIc1 = this->codebox_tilde_03_svfIc1;
        auto __codebox_tilde_03_attackEnv = this->codebox_tilde_03_attackEnv;
        auto __codebox_tilde_03_noiseEnv = this->codebox_tilde_03_noiseEnv;
        auto __codebox_tilde_03_metalEnv = this->codebox_tilde_03_metalEnv;
        auto __codebox_tilde_03_hitLevel = this->codebox_tilde_03_hitLevel;
        auto __codebox_tilde_03_hitDrive = this->codebox_tilde_03_hitDrive;
        auto __codebox_tilde_03_hitAttack = this->codebox_tilde_03_hitAttack;
        auto __codebox_tilde_03_hitFilterQ = this->codebox_tilde_03_hitFilterQ;
        auto __codebox_tilde_03_hitNoiseLevel = this->codebox_tilde_03_hitNoiseLevel;
        auto __codebox_tilde_03_hitMetalLevel = this->codebox_tilde_03_hitMetalLevel;
        auto __codebox_tilde_03_hitFilterHz = this->codebox_tilde_03_hitFilterHz;
        auto __codebox_tilde_03_hitSpread = this->codebox_tilde_03_hitSpread;
        auto __codebox_tilde_03_hitDecay = this->codebox_tilde_03_hitDecay;
        auto __codebox_tilde_03_hitNoiseDecay = this->codebox_tilde_03_hitNoiseDecay;
        auto __codebox_tilde_03_hitInharmonicity = this->codebox_tilde_03_hitInharmonicity;
        auto __codebox_tilde_03_hitPitch = this->codebox_tilde_03_hitPitch;
        number sr = this->sr;
        Index i;
    
        for (i = 0; i < (Index)n; i++) {
            number trig = in1[(Index)i];
    
            if (trig > 0) {
                __codebox_tilde_03_hitPitch = in2[(Index)i];//#map:_###_obj_###_:30
                __codebox_tilde_03_hitInharmonicity = in3[(Index)i];//#map:_###_obj_###_:31
                __codebox_tilde_03_hitNoiseDecay = in4[(Index)i];//#map:_###_obj_###_:32
                __codebox_tilde_03_hitDecay = in5[(Index)i];//#map:_###_obj_###_:33
                __codebox_tilde_03_hitSpread = in6[(Index)i];//#map:_###_obj_###_:34
                __codebox_tilde_03_hitFilterHz = in7[(Index)i];//#map:_###_obj_###_:35
                __codebox_tilde_03_hitMetalLevel = in8[(Index)i];//#map:_###_obj_###_:36
                __codebox_tilde_03_hitNoiseLevel = in9[(Index)i];//#map:_###_obj_###_:37
                __codebox_tilde_03_hitFilterQ = in10[(Index)i];//#map:_###_obj_###_:38
                __codebox_tilde_03_hitAttack = in11[(Index)i];//#map:_###_obj_###_:39
                __codebox_tilde_03_hitDrive = in12[(Index)i];//#map:_###_obj_###_:40
                __codebox_tilde_03_hitLevel = in13[(Index)i];//#map:_###_obj_###_:41
                __codebox_tilde_03_metalEnv = 1;//#map:_###_obj_###_:42
                __codebox_tilde_03_noiseEnv = 1;//#map:_###_obj_###_:43
                __codebox_tilde_03_attackEnv = 1;//#map:_###_obj_###_:44
                __codebox_tilde_03_svfIc1 = 0;//#map:_###_obj_###_:45
                __codebox_tilde_03_svfIc2 = 0;//#map:_###_obj_###_:46
            }//#map:_###_obj_###_:29
    
            __codebox_tilde_03_metalEnv *= rnbo_exp(
                (this->maximum(5, __codebox_tilde_03_hitDecay) * 0.001 * sr == 0. ? 0. : -6.907755 / (this->maximum(5, __codebox_tilde_03_hitDecay) * 0.001 * sr))
            );//#map:_###_obj_###_:48
    
            __codebox_tilde_03_noiseEnv *= rnbo_exp(
                (this->maximum(5, __codebox_tilde_03_hitNoiseDecay) * 0.001 * sr == 0. ? 0. : -6.907755 / (this->maximum(5, __codebox_tilde_03_hitNoiseDecay) * 0.001 * sr))
            );//#map:_###_obj_###_:49
    
            __codebox_tilde_03_attackEnv *= rnbo_exp((0.008 * sr == 0. ? 0. : -6.907755 / (0.008 * sr)));//#map:_###_obj_###_:50
            auto pitch = this->maximum(100, __codebox_tilde_03_hitPitch);
            number spread = (__codebox_tilde_03_hitSpread > 4 ? 4 : (__codebox_tilde_03_hitSpread < 0.1 ? 0.1 : __codebox_tilde_03_hitSpread));
            number inh = (__codebox_tilde_03_hitInharmonicity > 1 ? 1 : (__codebox_tilde_03_hitInharmonicity < 0 ? 0 : __codebox_tilde_03_hitInharmonicity));
    
            __codebox_tilde_03_phase1 = this->wrap(
                __codebox_tilde_03_phase1 + ((sr == 0. ? 0. : this->minimum(pitch, sr * 0.22) / sr)),
                0,
                1
            );//#map:_###_obj_###_:57
    
            __codebox_tilde_03_phase2 = this->wrap(
                __codebox_tilde_03_phase2 + ((sr == 0. ? 0. : this->minimum(pitch * (1 + spread * (1 - 0.658 * inh)), sr * 0.22) / sr)),
                0,
                1
            );//#map:_###_obj_###_:58
    
            __codebox_tilde_03_phase3 = this->wrap(
                __codebox_tilde_03_phase3 + ((sr == 0. ? 0. : this->minimum(pitch * (1 + spread * (2 - 1.231 * inh)), sr * 0.22) / sr)),
                0,
                1
            );//#map:_###_obj_###_:59
    
            __codebox_tilde_03_phase4 = this->wrap(
                __codebox_tilde_03_phase4 + ((sr == 0. ? 0. : this->minimum(pitch * (1 + spread * (3 - 1.587 * inh)), sr * 0.22) / sr)),
                0,
                1
            );//#map:_###_obj_###_:60
    
            __codebox_tilde_03_phase5 = this->wrap(
                __codebox_tilde_03_phase5 + ((sr == 0. ? 0. : this->minimum(pitch * (1 + spread * (4 - 1.858 * inh)), sr * 0.22) / sr)),
                0,
                1
            );//#map:_###_obj_###_:61
    
            __codebox_tilde_03_phase6 = this->wrap(
                __codebox_tilde_03_phase6 + ((sr == 0. ? 0. : this->minimum(pitch * (1 + spread * (5 - 1.827 * inh)), sr * 0.22) / sr)),
                0,
                1
            );//#map:_###_obj_###_:62
    
            number m1 = rnbo_sin(__codebox_tilde_03_phase1 * 6.283185307179586);
            number m2 = rnbo_sin(__codebox_tilde_03_phase2 * 6.283185307179586);
            number m3 = rnbo_sin(__codebox_tilde_03_phase3 * 6.283185307179586);
            number m4 = rnbo_sin(__codebox_tilde_03_phase4 * 6.283185307179586);
            number m5 = rnbo_sin(__codebox_tilde_03_phase5 * 6.283185307179586);
            number m6 = rnbo_sin(__codebox_tilde_03_phase6 * 6.283185307179586);
            number metal = (m1 * m4 + m2 * m5 + m3 * m6) * 0.55 + (m2 + m4 + m6) * 0.12;
            __codebox_tilde_03_noiseState = this->wrap((__codebox_tilde_03_noiseState + 1) * 16807, 0, 2147483647) - 1;//#map:_###_obj_###_:72
            number white = (__codebox_tilde_03_noiseState + 1) / (number)1073741823.5 - 1;
            number excitation = metal * __codebox_tilde_03_metalEnv * ((__codebox_tilde_03_hitMetalLevel > 1 ? 1 : (__codebox_tilde_03_hitMetalLevel < 0 ? 0 : __codebox_tilde_03_hitMetalLevel))) + white * (__codebox_tilde_03_noiseEnv + __codebox_tilde_03_attackEnv * ((__codebox_tilde_03_hitAttack > 1 ? 1 : (__codebox_tilde_03_hitAttack < 0 ? 0 : __codebox_tilde_03_hitAttack)))) * ((__codebox_tilde_03_hitNoiseLevel > 1 ? 1 : (__codebox_tilde_03_hitNoiseLevel < 0 ? 0 : __codebox_tilde_03_hitNoiseLevel)));
    
            number g = rnbo_tan(
                (sr == 0. ? 0. : 3.141592653589793 * ((__codebox_tilde_03_hitFilterHz > sr * 0.45 ? sr * 0.45 : (__codebox_tilde_03_hitFilterHz < 100 ? 100 : __codebox_tilde_03_hitFilterHz))) / sr)
            );
    
            number k = (this->maximum(0.5, __codebox_tilde_03_hitFilterQ) == 0. ? 0. : (number)1 / this->maximum(0.5, __codebox_tilde_03_hitFilterQ));
            number a1 = (1 + g * (g + k) == 0. ? 0. : (number)1 / (1 + g * (g + k)));
            number a2 = g * a1;
            number a3 = g * a2;
            number v3 = excitation - __codebox_tilde_03_svfIc2;
            number band = a1 * __codebox_tilde_03_svfIc1 + a2 * v3;
            number low = __codebox_tilde_03_svfIc2 + a2 * __codebox_tilde_03_svfIc1 + a3 * v3;
            __codebox_tilde_03_svfIc1 = 2 * band - __codebox_tilde_03_svfIc1;//#map:_###_obj_###_:85
            __codebox_tilde_03_svfIc2 = 2 * low - __codebox_tilde_03_svfIc2;//#map:_###_obj_###_:86
            number high = excitation - k * band - low;
            number raw = high * 0.7 + band * k * 0.8;
            auto drive = this->maximum(0.25, __codebox_tilde_03_hitDrive);
            out1[(Index)i] = ((rnbo_tanh(drive) == 0. ? 0. : rnbo_tanh(raw * drive) / rnbo_tanh(drive))) * ((__codebox_tilde_03_hitLevel > 1 ? 1 : (__codebox_tilde_03_hitLevel < 0 ? 0 : __codebox_tilde_03_hitLevel)));//#map:_###_obj_###_:90
        }
    
        this->codebox_tilde_03_hitPitch = __codebox_tilde_03_hitPitch;
        this->codebox_tilde_03_hitInharmonicity = __codebox_tilde_03_hitInharmonicity;
        this->codebox_tilde_03_hitNoiseDecay = __codebox_tilde_03_hitNoiseDecay;
        this->codebox_tilde_03_hitDecay = __codebox_tilde_03_hitDecay;
        this->codebox_tilde_03_hitSpread = __codebox_tilde_03_hitSpread;
        this->codebox_tilde_03_hitFilterHz = __codebox_tilde_03_hitFilterHz;
        this->codebox_tilde_03_hitMetalLevel = __codebox_tilde_03_hitMetalLevel;
        this->codebox_tilde_03_hitNoiseLevel = __codebox_tilde_03_hitNoiseLevel;
        this->codebox_tilde_03_hitFilterQ = __codebox_tilde_03_hitFilterQ;
        this->codebox_tilde_03_hitAttack = __codebox_tilde_03_hitAttack;
        this->codebox_tilde_03_hitDrive = __codebox_tilde_03_hitDrive;
        this->codebox_tilde_03_hitLevel = __codebox_tilde_03_hitLevel;
        this->codebox_tilde_03_metalEnv = __codebox_tilde_03_metalEnv;
        this->codebox_tilde_03_noiseEnv = __codebox_tilde_03_noiseEnv;
        this->codebox_tilde_03_attackEnv = __codebox_tilde_03_attackEnv;
        this->codebox_tilde_03_svfIc1 = __codebox_tilde_03_svfIc1;
        this->codebox_tilde_03_svfIc2 = __codebox_tilde_03_svfIc2;
        this->codebox_tilde_03_phase1 = __codebox_tilde_03_phase1;
        this->codebox_tilde_03_phase2 = __codebox_tilde_03_phase2;
        this->codebox_tilde_03_phase3 = __codebox_tilde_03_phase3;
        this->codebox_tilde_03_phase4 = __codebox_tilde_03_phase4;
        this->codebox_tilde_03_phase5 = __codebox_tilde_03_phase5;
        this->codebox_tilde_03_phase6 = __codebox_tilde_03_phase6;
        this->codebox_tilde_03_noiseState = __codebox_tilde_03_noiseState;
    }
    
    void dspexpr_03_perform(const Sample * in1, number in2, SampleValue * out1, Index n) {
        RNBO_UNUSED(in2);
        Index i;
    
        for (i = 0; i < (Index)n; i++) {
            out1[(Index)i] = in1[(Index)i] * 1;//#map:_###_obj_###_:1
        }
    }
    
    void signalforwarder_05_perform(const SampleValue * input, SampleValue * output, Index n) {
        copySignal(output, input, n);
    }
    
    void signalforwarder_06_perform(const SampleValue * input, SampleValue * output, Index n) {
        copySignal(output, input, n);
    }
    
    void stackprotect_perform(Index n) {
        RNBO_UNUSED(n);
        auto __stackprotect_count = this->stackprotect_count;
        __stackprotect_count = 0;
        this->stackprotect_count = __stackprotect_count;
    }
    
    void ip_25_init() {
        this->ip_25_lastValue = this->ip_25_value;
    }
    
    void ip_25_fillSigBuf() {
        if ((bool)(this->ip_25_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_25_lastIndex); i < k; i++) {
                if (this->ip_25_resetCount > 0) {
                    this->ip_25_sigbuf[(Index)i] = 1;
                    this->ip_25_resetCount--;
                } else {
                    this->ip_25_sigbuf[(Index)i] = this->ip_25_lastValue;
                }
            }
    
            this->ip_25_lastIndex = k;
        }
    }
    
    void ip_25_dspsetup(bool force) {
        if ((bool)(this->ip_25_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_25_lastIndex = 0;
        this->ip_25_setupDone = true;
    }
    
    void ip_26_init() {
        this->ip_26_lastValue = this->ip_26_value;
    }
    
    void ip_26_fillSigBuf() {
        if ((bool)(this->ip_26_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_26_lastIndex); i < k; i++) {
                if (this->ip_26_resetCount > 0) {
                    this->ip_26_sigbuf[(Index)i] = 1;
                    this->ip_26_resetCount--;
                } else {
                    this->ip_26_sigbuf[(Index)i] = this->ip_26_lastValue;
                }
            }
    
            this->ip_26_lastIndex = k;
        }
    }
    
    void ip_26_dspsetup(bool force) {
        if ((bool)(this->ip_26_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_26_lastIndex = 0;
        this->ip_26_setupDone = true;
    }
    
    void ip_27_init() {
        this->ip_27_lastValue = this->ip_27_value;
    }
    
    void ip_27_fillSigBuf() {
        if ((bool)(this->ip_27_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_27_lastIndex); i < k; i++) {
                if (this->ip_27_resetCount > 0) {
                    this->ip_27_sigbuf[(Index)i] = 1;
                    this->ip_27_resetCount--;
                } else {
                    this->ip_27_sigbuf[(Index)i] = this->ip_27_lastValue;
                }
            }
    
            this->ip_27_lastIndex = k;
        }
    }
    
    void ip_27_dspsetup(bool force) {
        if ((bool)(this->ip_27_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_27_lastIndex = 0;
        this->ip_27_setupDone = true;
    }
    
    void ip_28_init() {
        this->ip_28_lastValue = this->ip_28_value;
    }
    
    void ip_28_fillSigBuf() {
        if ((bool)(this->ip_28_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_28_lastIndex); i < k; i++) {
                if (this->ip_28_resetCount > 0) {
                    this->ip_28_sigbuf[(Index)i] = 1;
                    this->ip_28_resetCount--;
                } else {
                    this->ip_28_sigbuf[(Index)i] = this->ip_28_lastValue;
                }
            }
    
            this->ip_28_lastIndex = k;
        }
    }
    
    void ip_28_dspsetup(bool force) {
        if ((bool)(this->ip_28_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_28_lastIndex = 0;
        this->ip_28_setupDone = true;
    }
    
    void ip_29_init() {
        this->ip_29_lastValue = this->ip_29_value;
    }
    
    void ip_29_fillSigBuf() {
        if ((bool)(this->ip_29_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_29_lastIndex); i < k; i++) {
                if (this->ip_29_resetCount > 0) {
                    this->ip_29_sigbuf[(Index)i] = 1;
                    this->ip_29_resetCount--;
                } else {
                    this->ip_29_sigbuf[(Index)i] = this->ip_29_lastValue;
                }
            }
    
            this->ip_29_lastIndex = k;
        }
    }
    
    void ip_29_dspsetup(bool force) {
        if ((bool)(this->ip_29_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_29_lastIndex = 0;
        this->ip_29_setupDone = true;
    }
    
    void ip_30_init() {
        this->ip_30_lastValue = this->ip_30_value;
    }
    
    void ip_30_fillSigBuf() {
        if ((bool)(this->ip_30_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_30_lastIndex); i < k; i++) {
                if (this->ip_30_resetCount > 0) {
                    this->ip_30_sigbuf[(Index)i] = 1;
                    this->ip_30_resetCount--;
                } else {
                    this->ip_30_sigbuf[(Index)i] = this->ip_30_lastValue;
                }
            }
    
            this->ip_30_lastIndex = k;
        }
    }
    
    void ip_30_dspsetup(bool force) {
        if ((bool)(this->ip_30_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_30_lastIndex = 0;
        this->ip_30_setupDone = true;
    }
    
    void ip_31_init() {
        this->ip_31_lastValue = this->ip_31_value;
    }
    
    void ip_31_fillSigBuf() {
        if ((bool)(this->ip_31_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_31_lastIndex); i < k; i++) {
                if (this->ip_31_resetCount > 0) {
                    this->ip_31_sigbuf[(Index)i] = 1;
                    this->ip_31_resetCount--;
                } else {
                    this->ip_31_sigbuf[(Index)i] = this->ip_31_lastValue;
                }
            }
    
            this->ip_31_lastIndex = k;
        }
    }
    
    void ip_31_dspsetup(bool force) {
        if ((bool)(this->ip_31_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_31_lastIndex = 0;
        this->ip_31_setupDone = true;
    }
    
    void ip_32_init() {
        this->ip_32_lastValue = this->ip_32_value;
    }
    
    void ip_32_fillSigBuf() {
        if ((bool)(this->ip_32_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_32_lastIndex); i < k; i++) {
                if (this->ip_32_resetCount > 0) {
                    this->ip_32_sigbuf[(Index)i] = 1;
                    this->ip_32_resetCount--;
                } else {
                    this->ip_32_sigbuf[(Index)i] = this->ip_32_lastValue;
                }
            }
    
            this->ip_32_lastIndex = k;
        }
    }
    
    void ip_32_dspsetup(bool force) {
        if ((bool)(this->ip_32_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_32_lastIndex = 0;
        this->ip_32_setupDone = true;
    }
    
    void ip_33_init() {
        this->ip_33_lastValue = this->ip_33_value;
    }
    
    void ip_33_fillSigBuf() {
        if ((bool)(this->ip_33_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_33_lastIndex); i < k; i++) {
                if (this->ip_33_resetCount > 0) {
                    this->ip_33_sigbuf[(Index)i] = 1;
                    this->ip_33_resetCount--;
                } else {
                    this->ip_33_sigbuf[(Index)i] = this->ip_33_lastValue;
                }
            }
    
            this->ip_33_lastIndex = k;
        }
    }
    
    void ip_33_dspsetup(bool force) {
        if ((bool)(this->ip_33_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_33_lastIndex = 0;
        this->ip_33_setupDone = true;
    }
    
    void ip_34_init() {
        this->ip_34_lastValue = this->ip_34_value;
    }
    
    void ip_34_fillSigBuf() {
        if ((bool)(this->ip_34_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_34_lastIndex); i < k; i++) {
                if (this->ip_34_resetCount > 0) {
                    this->ip_34_sigbuf[(Index)i] = 1;
                    this->ip_34_resetCount--;
                } else {
                    this->ip_34_sigbuf[(Index)i] = this->ip_34_lastValue;
                }
            }
    
            this->ip_34_lastIndex = k;
        }
    }
    
    void ip_34_dspsetup(bool force) {
        if ((bool)(this->ip_34_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_34_lastIndex = 0;
        this->ip_34_setupDone = true;
    }
    
    void ip_35_init() {
        this->ip_35_lastValue = this->ip_35_value;
    }
    
    void ip_35_fillSigBuf() {
        if ((bool)(this->ip_35_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_35_lastIndex); i < k; i++) {
                if (this->ip_35_resetCount > 0) {
                    this->ip_35_sigbuf[(Index)i] = 1;
                    this->ip_35_resetCount--;
                } else {
                    this->ip_35_sigbuf[(Index)i] = this->ip_35_lastValue;
                }
            }
    
            this->ip_35_lastIndex = k;
        }
    }
    
    void ip_35_dspsetup(bool force) {
        if ((bool)(this->ip_35_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_35_lastIndex = 0;
        this->ip_35_setupDone = true;
    }
    
    void ip_36_init() {
        this->ip_36_lastValue = this->ip_36_value;
    }
    
    void ip_36_fillSigBuf() {
        if ((bool)(this->ip_36_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_36_lastIndex); i < k; i++) {
                if (this->ip_36_resetCount > 0) {
                    this->ip_36_sigbuf[(Index)i] = 1;
                    this->ip_36_resetCount--;
                } else {
                    this->ip_36_sigbuf[(Index)i] = this->ip_36_lastValue;
                }
            }
    
            this->ip_36_lastIndex = k;
        }
    }
    
    void ip_36_dspsetup(bool force) {
        if ((bool)(this->ip_36_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_36_lastIndex = 0;
        this->ip_36_setupDone = true;
    }
    
    bool stackprotect_check() {
        this->stackprotect_count++;
    
        if (this->stackprotect_count > 128) {
            console->log("STACK OVERFLOW DETECTED - stopped processing branch !");
            return true;
        }
    
        return false;
    }
    
    Index getPatcherSerial() const {
        return 0;
    }
    
    void sendParameter(ParameterIndex index, bool ignoreValue) {
        this->getPatcher()->sendParameter(index + this->parameterOffset, ignoreValue);
    }
    
    void scheduleParamInit(ParameterIndex index, Index order) {
        this->getPatcher()->scheduleParamInit(index + this->parameterOffset, order);
    }
    
    void updateTime(MillisecondTime time, EXTERNALENGINE* engine, bool inProcess = false) {
        RNBO_UNUSED(inProcess);
        RNBO_UNUSED(engine);
        this->_currentTime = time;
        auto offset = rnbo_fround(this->msToSamps(time - this->getEngine()->getCurrentTime(), this->sr));
    
        if (offset >= (SampleIndex)(this->vs))
            offset = (SampleIndex)(this->vs) - 1;
    
        if (offset < 0)
            offset = 0;
    
        this->sampleOffsetIntoNextAudioBuffer = (Index)(offset);
    }
    
    void assign_defaults()
    {
        ip_25_value = 0;
        ip_25_impulse = 0;
        ip_26_value = 0;
        ip_26_impulse = 0;
        ip_27_value = 0;
        ip_27_impulse = 0;
        ip_28_value = 0;
        ip_28_impulse = 0;
        ip_29_value = 0;
        ip_29_impulse = 0;
        ip_30_value = 0;
        ip_30_impulse = 0;
        ip_31_value = 0;
        ip_31_impulse = 0;
        ip_32_value = 0;
        ip_32_impulse = 0;
        ip_33_value = 0;
        ip_33_impulse = 0;
        ip_34_value = 0;
        ip_34_impulse = 0;
        ip_35_value = 0;
        ip_35_impulse = 0;
        ip_36_value = 0;
        ip_36_impulse = 0;
        codebox_tilde_03_in1 = 0;
        codebox_tilde_03_in2 = 0;
        codebox_tilde_03_in3 = 0;
        codebox_tilde_03_in4 = 0;
        codebox_tilde_03_in5 = 0;
        codebox_tilde_03_in6 = 0;
        codebox_tilde_03_in7 = 0;
        codebox_tilde_03_in8 = 0;
        codebox_tilde_03_in9 = 0;
        codebox_tilde_03_in10 = 0;
        codebox_tilde_03_in11 = 0;
        codebox_tilde_03_in12 = 0;
        codebox_tilde_03_in13 = 0;
        dspexpr_03_in1 = 0;
        dspexpr_03_in2 = 1;
        _currentTime = 0;
        audioProcessSampleCount = 0;
        sampleOffsetIntoNextAudioBuffer = 0;
        zeroBuffer = nullptr;
        dummyBuffer = nullptr;
        signals[0] = nullptr;
        signals[1] = nullptr;
        signals[2] = nullptr;
        signals[3] = nullptr;
        signals[4] = nullptr;
        signals[5] = nullptr;
        signals[6] = nullptr;
        signals[7] = nullptr;
        signals[8] = nullptr;
        signals[9] = nullptr;
        signals[10] = nullptr;
        signals[11] = nullptr;
        signals[12] = nullptr;
        signals[13] = nullptr;
        didAllocateSignals = 0;
        vs = 0;
        maxvs = 0;
        sr = 44100;
        invsr = 0.000022675736961451248;
        click_03_lastclick = -1;
        click_03_buf = nullptr;
        ip_25_lastIndex = 0;
        ip_25_lastValue = 0;
        ip_25_resetCount = 0;
        ip_25_sigbuf = nullptr;
        ip_25_setupDone = false;
        ip_26_lastIndex = 0;
        ip_26_lastValue = 0;
        ip_26_resetCount = 0;
        ip_26_sigbuf = nullptr;
        ip_26_setupDone = false;
        ip_27_lastIndex = 0;
        ip_27_lastValue = 0;
        ip_27_resetCount = 0;
        ip_27_sigbuf = nullptr;
        ip_27_setupDone = false;
        ip_28_lastIndex = 0;
        ip_28_lastValue = 0;
        ip_28_resetCount = 0;
        ip_28_sigbuf = nullptr;
        ip_28_setupDone = false;
        ip_29_lastIndex = 0;
        ip_29_lastValue = 0;
        ip_29_resetCount = 0;
        ip_29_sigbuf = nullptr;
        ip_29_setupDone = false;
        ip_30_lastIndex = 0;
        ip_30_lastValue = 0;
        ip_30_resetCount = 0;
        ip_30_sigbuf = nullptr;
        ip_30_setupDone = false;
        ip_31_lastIndex = 0;
        ip_31_lastValue = 0;
        ip_31_resetCount = 0;
        ip_31_sigbuf = nullptr;
        ip_31_setupDone = false;
        ip_32_lastIndex = 0;
        ip_32_lastValue = 0;
        ip_32_resetCount = 0;
        ip_32_sigbuf = nullptr;
        ip_32_setupDone = false;
        ip_33_lastIndex = 0;
        ip_33_lastValue = 0;
        ip_33_resetCount = 0;
        ip_33_sigbuf = nullptr;
        ip_33_setupDone = false;
        ip_34_lastIndex = 0;
        ip_34_lastValue = 0;
        ip_34_resetCount = 0;
        ip_34_sigbuf = nullptr;
        ip_34_setupDone = false;
        ip_35_lastIndex = 0;
        ip_35_lastValue = 0;
        ip_35_resetCount = 0;
        ip_35_sigbuf = nullptr;
        ip_35_setupDone = false;
        ip_36_lastIndex = 0;
        ip_36_lastValue = 0;
        ip_36_resetCount = 0;
        ip_36_sigbuf = nullptr;
        ip_36_setupDone = false;
        codebox_tilde_03_hitPitch = 700;
        codebox_tilde_03_hitInharmonicity = 0.65;
        codebox_tilde_03_hitNoiseDecay = 85;
        codebox_tilde_03_hitDecay = 120;
        codebox_tilde_03_hitSpread = 1;
        codebox_tilde_03_hitFilterHz = 6500;
        codebox_tilde_03_hitMetalLevel = 0.7;
        codebox_tilde_03_hitNoiseLevel = 0.55;
        codebox_tilde_03_hitFilterQ = 0.8;
        codebox_tilde_03_hitAttack = 0.4;
        codebox_tilde_03_hitDrive = 1.4;
        codebox_tilde_03_hitLevel = 0.4;
        codebox_tilde_03_metalEnv = 0;
        codebox_tilde_03_noiseEnv = 0;
        codebox_tilde_03_attackEnv = 0;
        codebox_tilde_03_phase1 = 0;
        codebox_tilde_03_phase2 = 0;
        codebox_tilde_03_phase3 = 0;
        codebox_tilde_03_phase4 = 0;
        codebox_tilde_03_phase5 = 0;
        codebox_tilde_03_phase6 = 0;
        codebox_tilde_03_noiseState = 12344;
        codebox_tilde_03_svfIc1 = 0;
        codebox_tilde_03_svfIc2 = 0;
        stackprotect_count = 0;
        _voiceIndex = 0;
        _noteNumber = 0;
        isMuted = 1;
        parameterOffset = 0;
    }
    
    // member variables
    
        number ip_25_value;
        number ip_25_impulse;
        number ip_26_value;
        number ip_26_impulse;
        number ip_27_value;
        number ip_27_impulse;
        number ip_28_value;
        number ip_28_impulse;
        number ip_29_value;
        number ip_29_impulse;
        number ip_30_value;
        number ip_30_impulse;
        number ip_31_value;
        number ip_31_impulse;
        number ip_32_value;
        number ip_32_impulse;
        number ip_33_value;
        number ip_33_impulse;
        number ip_34_value;
        number ip_34_impulse;
        number ip_35_value;
        number ip_35_impulse;
        number ip_36_value;
        number ip_36_impulse;
        number codebox_tilde_03_in1;
        number codebox_tilde_03_in2;
        number codebox_tilde_03_in3;
        number codebox_tilde_03_in4;
        number codebox_tilde_03_in5;
        number codebox_tilde_03_in6;
        number codebox_tilde_03_in7;
        number codebox_tilde_03_in8;
        number codebox_tilde_03_in9;
        number codebox_tilde_03_in10;
        number codebox_tilde_03_in11;
        number codebox_tilde_03_in12;
        number codebox_tilde_03_in13;
        number dspexpr_03_in1;
        number dspexpr_03_in2;
        MillisecondTime _currentTime;
        UInt64 audioProcessSampleCount;
        Index sampleOffsetIntoNextAudioBuffer;
        signal zeroBuffer;
        signal dummyBuffer;
        SampleValue * signals[14];
        bool didAllocateSignals;
        Index vs;
        Index maxvs;
        number sr;
        number invsr;
        SampleIndex click_03_lastclick;
        signal click_03_buf;
        SampleIndex ip_25_lastIndex;
        number ip_25_lastValue;
        SampleIndex ip_25_resetCount;
        signal ip_25_sigbuf;
        bool ip_25_setupDone;
        SampleIndex ip_26_lastIndex;
        number ip_26_lastValue;
        SampleIndex ip_26_resetCount;
        signal ip_26_sigbuf;
        bool ip_26_setupDone;
        SampleIndex ip_27_lastIndex;
        number ip_27_lastValue;
        SampleIndex ip_27_resetCount;
        signal ip_27_sigbuf;
        bool ip_27_setupDone;
        SampleIndex ip_28_lastIndex;
        number ip_28_lastValue;
        SampleIndex ip_28_resetCount;
        signal ip_28_sigbuf;
        bool ip_28_setupDone;
        SampleIndex ip_29_lastIndex;
        number ip_29_lastValue;
        SampleIndex ip_29_resetCount;
        signal ip_29_sigbuf;
        bool ip_29_setupDone;
        SampleIndex ip_30_lastIndex;
        number ip_30_lastValue;
        SampleIndex ip_30_resetCount;
        signal ip_30_sigbuf;
        bool ip_30_setupDone;
        SampleIndex ip_31_lastIndex;
        number ip_31_lastValue;
        SampleIndex ip_31_resetCount;
        signal ip_31_sigbuf;
        bool ip_31_setupDone;
        SampleIndex ip_32_lastIndex;
        number ip_32_lastValue;
        SampleIndex ip_32_resetCount;
        signal ip_32_sigbuf;
        bool ip_32_setupDone;
        SampleIndex ip_33_lastIndex;
        number ip_33_lastValue;
        SampleIndex ip_33_resetCount;
        signal ip_33_sigbuf;
        bool ip_33_setupDone;
        SampleIndex ip_34_lastIndex;
        number ip_34_lastValue;
        SampleIndex ip_34_resetCount;
        signal ip_34_sigbuf;
        bool ip_34_setupDone;
        SampleIndex ip_35_lastIndex;
        number ip_35_lastValue;
        SampleIndex ip_35_resetCount;
        signal ip_35_sigbuf;
        bool ip_35_setupDone;
        SampleIndex ip_36_lastIndex;
        number ip_36_lastValue;
        SampleIndex ip_36_resetCount;
        signal ip_36_sigbuf;
        bool ip_36_setupDone;
        number codebox_tilde_03_hitPitch;
        number codebox_tilde_03_hitInharmonicity;
        number codebox_tilde_03_hitNoiseDecay;
        number codebox_tilde_03_hitDecay;
        number codebox_tilde_03_hitSpread;
        number codebox_tilde_03_hitFilterHz;
        number codebox_tilde_03_hitMetalLevel;
        number codebox_tilde_03_hitNoiseLevel;
        number codebox_tilde_03_hitFilterQ;
        number codebox_tilde_03_hitAttack;
        number codebox_tilde_03_hitDrive;
        number codebox_tilde_03_hitLevel;
        number codebox_tilde_03_metalEnv;
        number codebox_tilde_03_noiseEnv;
        number codebox_tilde_03_attackEnv;
        number codebox_tilde_03_phase1;
        number codebox_tilde_03_phase2;
        number codebox_tilde_03_phase3;
        number codebox_tilde_03_phase4;
        number codebox_tilde_03_phase5;
        number codebox_tilde_03_phase6;
        number codebox_tilde_03_noiseState;
        number codebox_tilde_03_svfIc1;
        number codebox_tilde_03_svfIc2;
        number stackprotect_count;
        Index _voiceIndex;
        Int _noteNumber;
        Index isMuted;
        ParameterIndex parameterOffset;
        bool _isInitialized = false;
};

class RNBOSubpatcher_121 : public PatcherInterfaceImpl {
    
    friend class rnbomatic;
    
    public:
    
    RNBOSubpatcher_121()
    {}
    
    ~RNBOSubpatcher_121()
    {
        deallocateSignals();
    }
    
    Index getNumMidiInputPorts() const {
        return 0;
    }
    
    void processMidiEvent(MillisecondTime , int , ConstByteArray , Index ) {}
    
    Index getNumMidiOutputPorts() const {
        return 0;
    }
    
    void process(
        const SampleValue * const* inputs,
        Index numInputs,
        SampleValue * const* outputs,
        Index numOutputs,
        Index n
    ) {
        RNBO_UNUSED(numInputs);
        RNBO_UNUSED(inputs);
        this->vs = n;
        this->updateTime(this->getEngine()->getCurrentTime(), (ENGINE*)nullptr, true);
        SampleValue * out1 = (numOutputs >= 1 && outputs[0] ? outputs[0] : this->dummyBuffer);
        SampleValue * out2 = (numOutputs >= 2 && outputs[1] ? outputs[1] : this->dummyBuffer);
        this->click_04_perform(this->signals[0], n);
        this->ip_37_perform(this->signals[1], n);
        this->ip_38_perform(this->signals[2], n);
        this->ip_39_perform(this->signals[3], n);
        this->ip_40_perform(this->signals[4], n);
        this->ip_41_perform(this->signals[5], n);
        this->ip_42_perform(this->signals[6], n);
        this->ip_43_perform(this->signals[7], n);
        this->ip_44_perform(this->signals[8], n);
        this->ip_45_perform(this->signals[9], n);
        this->ip_46_perform(this->signals[10], n);
        this->ip_47_perform(this->signals[11], n);
        this->ip_48_perform(this->signals[12], n);
    
        this->codebox_tilde_04_perform(
            this->signals[0],
            this->signals[1],
            this->signals[2],
            this->signals[3],
            this->signals[4],
            this->signals[5],
            this->signals[6],
            this->signals[7],
            this->signals[8],
            this->signals[9],
            this->signals[10],
            this->signals[11],
            this->signals[12],
            this->signals[13],
            n
        );
    
        this->dspexpr_04_perform(this->signals[13], this->dspexpr_04_in2, this->signals[12], n);
        this->signalforwarder_07_perform(this->signals[12], out2, n);
        this->signalforwarder_08_perform(this->signals[12], out1, n);
        this->stackprotect_perform(n);
        this->audioProcessSampleCount += this->vs;
    }
    
    void prepareToProcess(number sampleRate, Index maxBlockSize, bool force) {
        RNBO_ASSERT(this->_isInitialized);
    
        if (this->maxvs < maxBlockSize || !this->didAllocateSignals) {
            Index i;
    
            for (i = 0; i < 14; i++) {
                this->signals[i] = resizeSignal(this->signals[i], this->maxvs, maxBlockSize);
            }
    
            this->click_04_buf = resizeSignal(this->click_04_buf, this->maxvs, maxBlockSize);
            this->ip_37_sigbuf = resizeSignal(this->ip_37_sigbuf, this->maxvs, maxBlockSize);
            this->ip_38_sigbuf = resizeSignal(this->ip_38_sigbuf, this->maxvs, maxBlockSize);
            this->ip_39_sigbuf = resizeSignal(this->ip_39_sigbuf, this->maxvs, maxBlockSize);
            this->ip_40_sigbuf = resizeSignal(this->ip_40_sigbuf, this->maxvs, maxBlockSize);
            this->ip_41_sigbuf = resizeSignal(this->ip_41_sigbuf, this->maxvs, maxBlockSize);
            this->ip_42_sigbuf = resizeSignal(this->ip_42_sigbuf, this->maxvs, maxBlockSize);
            this->ip_43_sigbuf = resizeSignal(this->ip_43_sigbuf, this->maxvs, maxBlockSize);
            this->ip_44_sigbuf = resizeSignal(this->ip_44_sigbuf, this->maxvs, maxBlockSize);
            this->ip_45_sigbuf = resizeSignal(this->ip_45_sigbuf, this->maxvs, maxBlockSize);
            this->ip_46_sigbuf = resizeSignal(this->ip_46_sigbuf, this->maxvs, maxBlockSize);
            this->ip_47_sigbuf = resizeSignal(this->ip_47_sigbuf, this->maxvs, maxBlockSize);
            this->ip_48_sigbuf = resizeSignal(this->ip_48_sigbuf, this->maxvs, maxBlockSize);
            this->zeroBuffer = resizeSignal(this->zeroBuffer, this->maxvs, maxBlockSize);
            this->dummyBuffer = resizeSignal(this->dummyBuffer, this->maxvs, maxBlockSize);
            this->didAllocateSignals = true;
        }
    
        const bool sampleRateChanged = sampleRate != this->sr;
        const bool maxvsChanged = maxBlockSize != this->maxvs;
        const bool forceDSPSetup = sampleRateChanged || maxvsChanged || force;
    
        if (sampleRateChanged || maxvsChanged) {
            this->vs = maxBlockSize;
            this->maxvs = maxBlockSize;
            this->sr = sampleRate;
            this->invsr = 1 / sampleRate;
        }
    
        this->ip_37_dspsetup(forceDSPSetup);
        this->ip_38_dspsetup(forceDSPSetup);
        this->ip_39_dspsetup(forceDSPSetup);
        this->ip_40_dspsetup(forceDSPSetup);
        this->ip_41_dspsetup(forceDSPSetup);
        this->ip_42_dspsetup(forceDSPSetup);
        this->ip_43_dspsetup(forceDSPSetup);
        this->ip_44_dspsetup(forceDSPSetup);
        this->ip_45_dspsetup(forceDSPSetup);
        this->ip_46_dspsetup(forceDSPSetup);
        this->ip_47_dspsetup(forceDSPSetup);
        this->ip_48_dspsetup(forceDSPSetup);
    
        if (sampleRateChanged)
            this->onSampleRateChanged(sampleRate);
    }
    
    number msToSamps(MillisecondTime ms, number sampleRate) {
        return ms * sampleRate * 0.001;
    }
    
    MillisecondTime sampsToMs(SampleIndex samps) {
        return samps * (this->invsr * 1000);
    }
    
    Index getNumInputChannels() const {
        return 0;
    }
    
    Index getNumOutputChannels() const {
        return 2;
    }
    
    void getPreset(PatcherStateInterface& ) {}
    
    void setPreset(MillisecondTime , PatcherStateInterface& ) {}
    
    void setParameterValue(ParameterIndex , ParameterValue , MillisecondTime ) {}
    
    void processParameterEvent(ParameterIndex index, ParameterValue value, MillisecondTime time) {
        this->setParameterValue(index, value, time);
    }
    
    void processParameterBangEvent(ParameterIndex index, MillisecondTime time) {
        this->setParameterValue(index, this->getParameterValue(index), time);
    }
    
    void processNormalizedParameterEvent(ParameterIndex index, ParameterValue value, MillisecondTime time) {
        this->setParameterValueNormalized(index, value, time);
    }
    
    ParameterValue getParameterValue(ParameterIndex index)  {
        switch (index) {
        default:
            {
            return 0;
            }
        }
    }
    
    ParameterIndex getNumSignalInParameters() const {
        return 0;
    }
    
    ParameterIndex getNumSignalOutParameters() const {
        return 0;
    }
    
    ParameterIndex getNumParameters() const {
        return 0;
    }
    
    ConstCharPointer getParameterName(ParameterIndex index) const {
        switch (index) {
        default:
            {
            return "bogus";
            }
        }
    }
    
    ConstCharPointer getParameterId(ParameterIndex index) const {
        switch (index) {
        default:
            {
            return "bogus";
            }
        }
    }
    
    void getParameterInfo(ParameterIndex , ParameterInfo * ) const {}
    
    ParameterValue applyStepsToNormalizedParameterValue(ParameterValue normalizedValue, int steps) const {
        if (steps == 1) {
            if (normalizedValue > 0) {
                normalizedValue = 1.;
            }
        } else {
            ParameterValue oneStep = (number)1. / (steps - 1);
            ParameterValue numberOfSteps = rnbo_fround(normalizedValue / oneStep * 1 / (number)1) * (number)1;
            normalizedValue = numberOfSteps * oneStep;
        }
    
        return normalizedValue;
    }
    
    ParameterValue convertToNormalizedParameterValue(ParameterIndex index, ParameterValue value) const {
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    ParameterValue convertFromNormalizedParameterValue(ParameterIndex index, ParameterValue value) const {
        value = (value < 0 ? 0 : (value > 1 ? 1 : value));
    
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    ParameterValue constrainParameterValue(ParameterIndex index, ParameterValue value) const {
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    void processNumMessage(MessageTag , MessageTag , MillisecondTime , number ) {}
    
    void processListMessage(MessageTag , MessageTag , MillisecondTime , const list& ) {}
    
    void processBangMessage(MessageTag , MessageTag , MillisecondTime ) {}
    
    MessageTagInfo resolveTag(MessageTag tag) const {
        switch (tag) {
    
        }
    
        return nullptr;
    }
    
    DataRef* getDataRef(DataRefIndex index)  {
        switch (index) {
        default:
            {
            return nullptr;
            }
        }
    }
    
    DataRefIndex getNumDataRefs() const {
        return 0;
    }
    
    void processDataViewUpdate(DataRefIndex , MillisecondTime ) {}
    
    void initialize() {
        RNBO_ASSERT(!this->_isInitialized);
        this->assign_defaults();
        this->applyState();
        this->_isInitialized = true;
    }
    
    protected:
    
    void updateTime(MillisecondTime time, INTERNALENGINE*, bool inProcess = false) {
    	if (time == TimeNow) time = getTopLevelPatcher()->getPatcherTime();
    	getTopLevelPatcher()->processInternalEvents(time);
    	updateTime(time, (EXTERNALENGINE*)nullptr);
    }
    
    RNBOSubpatcher_121* operator->() {
        return this;
    }
    const RNBOSubpatcher_121* operator->() const {
        return this;
    }
    virtual rnbomatic* getPatcher() const {
        return static_cast<rnbomatic *>(_parentPatcher);
    }
    
    rnbomatic* getTopLevelPatcher() {
        return this->getPatcher()->getTopLevelPatcher();
    }
    
    void cancelClockEvents()
    {
    }
    
    number maximum(number x, number y) {
        return (x < y ? y : x);
    }
    
    number wrap(number x, number low, number high) {
        number lo;
        number hi;
    
        if (low == high)
            return low;
    
        if (low > high) {
            hi = low;
            lo = high;
        } else {
            lo = low;
            hi = high;
        }
    
        number range = hi - lo;
    
        if (x >= lo && x < hi)
            return x;
    
        if (range <= 0.000000001)
            return lo;
    
        Int numWraps = (Int)(trunc((x - lo) / range));
        numWraps = numWraps - ((x < lo ? 1 : 0));
        number result = x - range * numWraps;
    
        if (result >= hi)
            return result - range;
        else
            return result;
    }
    
    MillisecondTime getPatcherTime() const {
        return this->_currentTime;
    }
    
    void eventinlet_41_out1_bang_bang() {
        this->ip_37_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_41_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_37_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_37_value_set(converted);
        }
    }
    
    void eventinlet_42_out1_bang_bang() {
        this->ip_38_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_42_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_38_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_38_value_set(converted);
        }
    }
    
    void eventinlet_43_out1_bang_bang() {
        this->ip_39_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_43_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_39_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_39_value_set(converted);
        }
    }
    
    void eventinlet_44_out1_bang_bang() {
        this->ip_40_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_44_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_40_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_40_value_set(converted);
        }
    }
    
    void eventinlet_45_out1_bang_bang() {
        this->ip_41_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_45_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_41_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_41_value_set(converted);
        }
    }
    
    void eventinlet_46_out1_bang_bang() {
        this->ip_42_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_46_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_42_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_42_value_set(converted);
        }
    }
    
    void eventinlet_47_out1_bang_bang() {
        this->ip_43_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_47_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_43_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_43_value_set(converted);
        }
    }
    
    void eventinlet_48_out1_bang_bang() {
        this->ip_44_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_48_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_44_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_44_value_set(converted);
        }
    }
    
    void eventinlet_49_out1_bang_bang() {
        this->ip_45_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_49_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_45_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_45_value_set(converted);
        }
    }
    
    void eventinlet_50_out1_bang_bang() {
        this->ip_46_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_50_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_46_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_46_value_set(converted);
        }
    }
    
    void eventinlet_51_out1_bang_bang() {
        this->ip_47_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_51_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_47_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_47_value_set(converted);
        }
    }
    
    void eventinlet_52_out1_bang_bang() {
        this->ip_48_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_52_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_48_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_48_value_set(converted);
        }
    }
    
    void deallocateSignals() {
        Index i;
    
        for (i = 0; i < 14; i++) {
            this->signals[i] = freeSignal(this->signals[i]);
        }
    
        this->click_04_buf = freeSignal(this->click_04_buf);
        this->ip_37_sigbuf = freeSignal(this->ip_37_sigbuf);
        this->ip_38_sigbuf = freeSignal(this->ip_38_sigbuf);
        this->ip_39_sigbuf = freeSignal(this->ip_39_sigbuf);
        this->ip_40_sigbuf = freeSignal(this->ip_40_sigbuf);
        this->ip_41_sigbuf = freeSignal(this->ip_41_sigbuf);
        this->ip_42_sigbuf = freeSignal(this->ip_42_sigbuf);
        this->ip_43_sigbuf = freeSignal(this->ip_43_sigbuf);
        this->ip_44_sigbuf = freeSignal(this->ip_44_sigbuf);
        this->ip_45_sigbuf = freeSignal(this->ip_45_sigbuf);
        this->ip_46_sigbuf = freeSignal(this->ip_46_sigbuf);
        this->ip_47_sigbuf = freeSignal(this->ip_47_sigbuf);
        this->ip_48_sigbuf = freeSignal(this->ip_48_sigbuf);
        this->zeroBuffer = freeSignal(this->zeroBuffer);
        this->dummyBuffer = freeSignal(this->dummyBuffer);
    }
    
    Index getMaxBlockSize() const {
        return this->maxvs;
    }
    
    number getSampleRate() const {
        return this->sr;
    }
    
    bool hasFixedVectorSize() const {
        return false;
    }
    
    void setProbingTarget(MessageTag ) {}
    
    void initializeObjects() {
        this->ip_37_init();
        this->ip_38_init();
        this->ip_39_init();
        this->ip_40_init();
        this->ip_41_init();
        this->ip_42_init();
        this->ip_43_init();
        this->ip_44_init();
        this->ip_45_init();
        this->ip_46_init();
        this->ip_47_init();
        this->ip_48_init();
    }
    
    Index getIsMuted()  {
        return this->isMuted;
    }
    
    void setIsMuted(Index v)  {
        this->isMuted = v;
    }
    
    void onSampleRateChanged(double ) {}
    
    void extractState(PatcherStateInterface& ) {}
    
    void applyState() {}
    
    void setParameterOffset(ParameterIndex offset) {
        this->parameterOffset = offset;
    }
    
    void processClockEvent(MillisecondTime , ClockId , bool , ParameterValue ) {}
    
    void processOutletAtCurrentTime(EngineLink* , OutletIndex , ParameterValue ) {}
    
    void processOutletEvent(
        EngineLink* sender,
        OutletIndex index,
        ParameterValue value,
        MillisecondTime time
    ) {
        this->updateTime(time, (ENGINE*)nullptr);
        this->processOutletAtCurrentTime(sender, index, value);
    }
    
    void sendOutlet(OutletIndex index, ParameterValue value) {
        this->getEngine()->sendOutlet(this, index, value);
    }
    
    void startup() {}
    
    void fillDataRef(DataRefIndex , DataRef& ) {}
    
    void allocateDataRefs() {}
    
    void ip_37_value_set(number v) {
        this->ip_37_value = v;
        this->ip_37_fillSigBuf();
        this->ip_37_lastValue = v;
    }
    
    void eventinlet_41_out1_number_set(number v) {
        this->ip_37_value_set(v);
    }
    
    void ip_38_value_set(number v) {
        this->ip_38_value = v;
        this->ip_38_fillSigBuf();
        this->ip_38_lastValue = v;
    }
    
    void eventinlet_42_out1_number_set(number v) {
        this->ip_38_value_set(v);
    }
    
    void ip_39_value_set(number v) {
        this->ip_39_value = v;
        this->ip_39_fillSigBuf();
        this->ip_39_lastValue = v;
    }
    
    void eventinlet_43_out1_number_set(number v) {
        this->ip_39_value_set(v);
    }
    
    void ip_40_value_set(number v) {
        this->ip_40_value = v;
        this->ip_40_fillSigBuf();
        this->ip_40_lastValue = v;
    }
    
    void eventinlet_44_out1_number_set(number v) {
        this->ip_40_value_set(v);
    }
    
    void ip_41_value_set(number v) {
        this->ip_41_value = v;
        this->ip_41_fillSigBuf();
        this->ip_41_lastValue = v;
    }
    
    void eventinlet_45_out1_number_set(number v) {
        this->ip_41_value_set(v);
    }
    
    void ip_42_value_set(number v) {
        this->ip_42_value = v;
        this->ip_42_fillSigBuf();
        this->ip_42_lastValue = v;
    }
    
    void eventinlet_46_out1_number_set(number v) {
        this->ip_42_value_set(v);
    }
    
    void ip_43_value_set(number v) {
        this->ip_43_value = v;
        this->ip_43_fillSigBuf();
        this->ip_43_lastValue = v;
    }
    
    void eventinlet_47_out1_number_set(number v) {
        this->ip_43_value_set(v);
    }
    
    void ip_44_value_set(number v) {
        this->ip_44_value = v;
        this->ip_44_fillSigBuf();
        this->ip_44_lastValue = v;
    }
    
    void eventinlet_48_out1_number_set(number v) {
        this->ip_44_value_set(v);
    }
    
    void ip_45_value_set(number v) {
        this->ip_45_value = v;
        this->ip_45_fillSigBuf();
        this->ip_45_lastValue = v;
    }
    
    void eventinlet_49_out1_number_set(number v) {
        this->ip_45_value_set(v);
    }
    
    void ip_46_value_set(number v) {
        this->ip_46_value = v;
        this->ip_46_fillSigBuf();
        this->ip_46_lastValue = v;
    }
    
    void eventinlet_50_out1_number_set(number v) {
        this->ip_46_value_set(v);
    }
    
    void ip_47_value_set(number v) {
        this->ip_47_value = v;
        this->ip_47_fillSigBuf();
        this->ip_47_lastValue = v;
    }
    
    void eventinlet_51_out1_number_set(number v) {
        this->ip_47_value_set(v);
    }
    
    void ip_48_value_set(number v) {
        this->ip_48_value = v;
        this->ip_48_fillSigBuf();
        this->ip_48_lastValue = v;
    }
    
    void eventinlet_52_out1_number_set(number v) {
        this->ip_48_value_set(v);
    }
    
    void click_04_click_number_set(number v) {
        for (SampleIndex i = (SampleIndex)(this->click_04_lastclick + 1); i < this->sampleOffsetIntoNextAudioBuffer; i++) {
            this->click_04_buf[(Index)i] = 0;
        }
    
        this->click_04_lastclick = this->sampleOffsetIntoNextAudioBuffer;
        this->click_04_buf[(Index)this->click_04_lastclick] = v;
    }
    
    void click_04_click_bang_bang() {
        this->click_04_click_number_set(1);
    }
    
    void eventinlet_40_out1_bang_bang() {
        this->click_04_click_bang_bang();
    }
    
    void eventinlet_40_out1_number_set(number v) {
        this->click_04_click_number_set(v);
    }
    
    template<typename LISTTYPE> void eventinlet_40_out1_list_set(const LISTTYPE& v) {
        {
            number converted = (v->length > 0 ? v[0] : 0);
            this->click_04_click_number_set(converted);
        }
    }
    
    void ip_37_value_bang() {
        number v = this->ip_37_value;
        this->ip_37_fillSigBuf();
        this->ip_37_lastValue = v;
    }
    
    void ip_37_impulse_set(number v) {
        this->ip_37_impulse = v;
        this->ip_37_fillSigBuf();
        this->ip_37_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_37_resetCount = lengthInSamples;
    }
    
    void ip_38_value_bang() {
        number v = this->ip_38_value;
        this->ip_38_fillSigBuf();
        this->ip_38_lastValue = v;
    }
    
    void ip_38_impulse_set(number v) {
        this->ip_38_impulse = v;
        this->ip_38_fillSigBuf();
        this->ip_38_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_38_resetCount = lengthInSamples;
    }
    
    void ip_39_value_bang() {
        number v = this->ip_39_value;
        this->ip_39_fillSigBuf();
        this->ip_39_lastValue = v;
    }
    
    void ip_39_impulse_set(number v) {
        this->ip_39_impulse = v;
        this->ip_39_fillSigBuf();
        this->ip_39_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_39_resetCount = lengthInSamples;
    }
    
    void ip_40_value_bang() {
        number v = this->ip_40_value;
        this->ip_40_fillSigBuf();
        this->ip_40_lastValue = v;
    }
    
    void ip_40_impulse_set(number v) {
        this->ip_40_impulse = v;
        this->ip_40_fillSigBuf();
        this->ip_40_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_40_resetCount = lengthInSamples;
    }
    
    void ip_41_value_bang() {
        number v = this->ip_41_value;
        this->ip_41_fillSigBuf();
        this->ip_41_lastValue = v;
    }
    
    void ip_41_impulse_set(number v) {
        this->ip_41_impulse = v;
        this->ip_41_fillSigBuf();
        this->ip_41_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_41_resetCount = lengthInSamples;
    }
    
    void ip_42_value_bang() {
        number v = this->ip_42_value;
        this->ip_42_fillSigBuf();
        this->ip_42_lastValue = v;
    }
    
    void ip_42_impulse_set(number v) {
        this->ip_42_impulse = v;
        this->ip_42_fillSigBuf();
        this->ip_42_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_42_resetCount = lengthInSamples;
    }
    
    void ip_43_value_bang() {
        number v = this->ip_43_value;
        this->ip_43_fillSigBuf();
        this->ip_43_lastValue = v;
    }
    
    void ip_43_impulse_set(number v) {
        this->ip_43_impulse = v;
        this->ip_43_fillSigBuf();
        this->ip_43_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_43_resetCount = lengthInSamples;
    }
    
    void ip_44_value_bang() {
        number v = this->ip_44_value;
        this->ip_44_fillSigBuf();
        this->ip_44_lastValue = v;
    }
    
    void ip_44_impulse_set(number v) {
        this->ip_44_impulse = v;
        this->ip_44_fillSigBuf();
        this->ip_44_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_44_resetCount = lengthInSamples;
    }
    
    void ip_45_value_bang() {
        number v = this->ip_45_value;
        this->ip_45_fillSigBuf();
        this->ip_45_lastValue = v;
    }
    
    void ip_45_impulse_set(number v) {
        this->ip_45_impulse = v;
        this->ip_45_fillSigBuf();
        this->ip_45_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_45_resetCount = lengthInSamples;
    }
    
    void ip_46_value_bang() {
        number v = this->ip_46_value;
        this->ip_46_fillSigBuf();
        this->ip_46_lastValue = v;
    }
    
    void ip_46_impulse_set(number v) {
        this->ip_46_impulse = v;
        this->ip_46_fillSigBuf();
        this->ip_46_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_46_resetCount = lengthInSamples;
    }
    
    void ip_47_value_bang() {
        number v = this->ip_47_value;
        this->ip_47_fillSigBuf();
        this->ip_47_lastValue = v;
    }
    
    void ip_47_impulse_set(number v) {
        this->ip_47_impulse = v;
        this->ip_47_fillSigBuf();
        this->ip_47_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_47_resetCount = lengthInSamples;
    }
    
    void ip_48_value_bang() {
        number v = this->ip_48_value;
        this->ip_48_fillSigBuf();
        this->ip_48_lastValue = v;
    }
    
    void ip_48_impulse_set(number v) {
        this->ip_48_impulse = v;
        this->ip_48_fillSigBuf();
        this->ip_48_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_48_resetCount = lengthInSamples;
    }
    
    void click_04_perform(SampleValue * out, Index n) {
        auto __click_04_lastclick = this->click_04_lastclick;
    
        for (SampleIndex i = 0; i <= __click_04_lastclick; i++) {
            out[(Index)i] = this->click_04_buf[(Index)i];
        }
    
        for (SampleIndex i = (SampleIndex)(__click_04_lastclick + 1); i < (SampleIndex)(n); i++) {
            out[(Index)i] = 0;
        }
    
        __click_04_lastclick = -1;
        this->click_04_lastclick = __click_04_lastclick;
    }
    
    void ip_37_perform(SampleValue * out, Index n) {
        auto __ip_37_lastValue = this->ip_37_lastValue;
        auto __ip_37_lastIndex = this->ip_37_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_37_lastIndex ? __ip_37_lastValue : this->ip_37_sigbuf[(Index)i]);
        }
    
        __ip_37_lastIndex = 0;
        this->ip_37_lastIndex = __ip_37_lastIndex;
    }
    
    void ip_38_perform(SampleValue * out, Index n) {
        auto __ip_38_lastValue = this->ip_38_lastValue;
        auto __ip_38_lastIndex = this->ip_38_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_38_lastIndex ? __ip_38_lastValue : this->ip_38_sigbuf[(Index)i]);
        }
    
        __ip_38_lastIndex = 0;
        this->ip_38_lastIndex = __ip_38_lastIndex;
    }
    
    void ip_39_perform(SampleValue * out, Index n) {
        auto __ip_39_lastValue = this->ip_39_lastValue;
        auto __ip_39_lastIndex = this->ip_39_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_39_lastIndex ? __ip_39_lastValue : this->ip_39_sigbuf[(Index)i]);
        }
    
        __ip_39_lastIndex = 0;
        this->ip_39_lastIndex = __ip_39_lastIndex;
    }
    
    void ip_40_perform(SampleValue * out, Index n) {
        auto __ip_40_lastValue = this->ip_40_lastValue;
        auto __ip_40_lastIndex = this->ip_40_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_40_lastIndex ? __ip_40_lastValue : this->ip_40_sigbuf[(Index)i]);
        }
    
        __ip_40_lastIndex = 0;
        this->ip_40_lastIndex = __ip_40_lastIndex;
    }
    
    void ip_41_perform(SampleValue * out, Index n) {
        auto __ip_41_lastValue = this->ip_41_lastValue;
        auto __ip_41_lastIndex = this->ip_41_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_41_lastIndex ? __ip_41_lastValue : this->ip_41_sigbuf[(Index)i]);
        }
    
        __ip_41_lastIndex = 0;
        this->ip_41_lastIndex = __ip_41_lastIndex;
    }
    
    void ip_42_perform(SampleValue * out, Index n) {
        auto __ip_42_lastValue = this->ip_42_lastValue;
        auto __ip_42_lastIndex = this->ip_42_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_42_lastIndex ? __ip_42_lastValue : this->ip_42_sigbuf[(Index)i]);
        }
    
        __ip_42_lastIndex = 0;
        this->ip_42_lastIndex = __ip_42_lastIndex;
    }
    
    void ip_43_perform(SampleValue * out, Index n) {
        auto __ip_43_lastValue = this->ip_43_lastValue;
        auto __ip_43_lastIndex = this->ip_43_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_43_lastIndex ? __ip_43_lastValue : this->ip_43_sigbuf[(Index)i]);
        }
    
        __ip_43_lastIndex = 0;
        this->ip_43_lastIndex = __ip_43_lastIndex;
    }
    
    void ip_44_perform(SampleValue * out, Index n) {
        auto __ip_44_lastValue = this->ip_44_lastValue;
        auto __ip_44_lastIndex = this->ip_44_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_44_lastIndex ? __ip_44_lastValue : this->ip_44_sigbuf[(Index)i]);
        }
    
        __ip_44_lastIndex = 0;
        this->ip_44_lastIndex = __ip_44_lastIndex;
    }
    
    void ip_45_perform(SampleValue * out, Index n) {
        auto __ip_45_lastValue = this->ip_45_lastValue;
        auto __ip_45_lastIndex = this->ip_45_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_45_lastIndex ? __ip_45_lastValue : this->ip_45_sigbuf[(Index)i]);
        }
    
        __ip_45_lastIndex = 0;
        this->ip_45_lastIndex = __ip_45_lastIndex;
    }
    
    void ip_46_perform(SampleValue * out, Index n) {
        auto __ip_46_lastValue = this->ip_46_lastValue;
        auto __ip_46_lastIndex = this->ip_46_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_46_lastIndex ? __ip_46_lastValue : this->ip_46_sigbuf[(Index)i]);
        }
    
        __ip_46_lastIndex = 0;
        this->ip_46_lastIndex = __ip_46_lastIndex;
    }
    
    void ip_47_perform(SampleValue * out, Index n) {
        auto __ip_47_lastValue = this->ip_47_lastValue;
        auto __ip_47_lastIndex = this->ip_47_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_47_lastIndex ? __ip_47_lastValue : this->ip_47_sigbuf[(Index)i]);
        }
    
        __ip_47_lastIndex = 0;
        this->ip_47_lastIndex = __ip_47_lastIndex;
    }
    
    void ip_48_perform(SampleValue * out, Index n) {
        auto __ip_48_lastValue = this->ip_48_lastValue;
        auto __ip_48_lastIndex = this->ip_48_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_48_lastIndex ? __ip_48_lastValue : this->ip_48_sigbuf[(Index)i]);
        }
    
        __ip_48_lastIndex = 0;
        this->ip_48_lastIndex = __ip_48_lastIndex;
    }
    
    void codebox_tilde_04_perform(
        const Sample * in1,
        const Sample * in2,
        const Sample * in3,
        const Sample * in4,
        const Sample * in5,
        const Sample * in6,
        const Sample * in7,
        const Sample * in8,
        const Sample * in9,
        const Sample * in10,
        const Sample * in11,
        const Sample * in12,
        const Sample * in13,
        SampleValue * out1,
        Index n
    ) {
        auto __codebox_tilde_04_noiseState = this->codebox_tilde_04_noiseState;
        auto __codebox_tilde_04_scatterState = this->codebox_tilde_04_scatterState;
        auto __codebox_tilde_04_countdown = this->codebox_tilde_04_countdown;
        auto __codebox_tilde_04_svfIc2 = this->codebox_tilde_04_svfIc2;
        auto __codebox_tilde_04_svfIc1 = this->codebox_tilde_04_svfIc1;
        auto __codebox_tilde_04_tailRise = this->codebox_tilde_04_tailRise;
        auto __codebox_tilde_04_tailEnv = this->codebox_tilde_04_tailEnv;
        auto __codebox_tilde_04_burstEnv = this->codebox_tilde_04_burstEnv;
        auto __codebox_tilde_04_burstsLeft = this->codebox_tilde_04_burstsLeft;
        auto __codebox_tilde_04_hitLevel = this->codebox_tilde_04_hitLevel;
        auto __codebox_tilde_04_hitDrive = this->codebox_tilde_04_hitDrive;
        auto __codebox_tilde_04_hitBrightness = this->codebox_tilde_04_hitBrightness;
        auto __codebox_tilde_04_hitFilterQ = this->codebox_tilde_04_hitFilterQ;
        auto __codebox_tilde_04_hitTailLevel = this->codebox_tilde_04_hitTailLevel;
        auto __codebox_tilde_04_hitBalance = this->codebox_tilde_04_hitBalance;
        auto __codebox_tilde_04_hitFilterHz = this->codebox_tilde_04_hitFilterHz;
        auto __codebox_tilde_04_hitSpacing = this->codebox_tilde_04_hitSpacing;
        auto __codebox_tilde_04_hitBurstDecay = this->codebox_tilde_04_hitBurstDecay;
        auto __codebox_tilde_04_hitTailDecay = this->codebox_tilde_04_hitTailDecay;
        auto __codebox_tilde_04_hitScatter = this->codebox_tilde_04_hitScatter;
        auto __codebox_tilde_04_hitCount = this->codebox_tilde_04_hitCount;
        Index i;
    
        for (i = 0; i < (Index)n; i++) {
            number trig = in1[(Index)i];
            number sr = this->sr;
            number burstPulse = 0;
    
            if (trig > 0) {
                __codebox_tilde_04_hitCount = in2[(Index)i];//#map:_###_obj_###_:28
                __codebox_tilde_04_hitScatter = in3[(Index)i];//#map:_###_obj_###_:29
                __codebox_tilde_04_hitTailDecay = in4[(Index)i];//#map:_###_obj_###_:30
                __codebox_tilde_04_hitBurstDecay = in5[(Index)i];//#map:_###_obj_###_:31
                __codebox_tilde_04_hitSpacing = in6[(Index)i];//#map:_###_obj_###_:32
                __codebox_tilde_04_hitFilterHz = in7[(Index)i];//#map:_###_obj_###_:33
                __codebox_tilde_04_hitBalance = in8[(Index)i];//#map:_###_obj_###_:34
                __codebox_tilde_04_hitTailLevel = in9[(Index)i];//#map:_###_obj_###_:35
                __codebox_tilde_04_hitFilterQ = in10[(Index)i];//#map:_###_obj_###_:36
                __codebox_tilde_04_hitBrightness = in11[(Index)i];//#map:_###_obj_###_:37
                __codebox_tilde_04_hitDrive = in12[(Index)i];//#map:_###_obj_###_:38
                __codebox_tilde_04_hitLevel = in13[(Index)i];//#map:_###_obj_###_:39
    
                __codebox_tilde_04_burstsLeft = rnbo_floor(
                    ((__codebox_tilde_04_hitCount > 8 ? 8 : (__codebox_tilde_04_hitCount < 1 ? 1 : __codebox_tilde_04_hitCount))) + 0.5
                ) - 1;//#map:_###_obj_###_:40
    
                burstPulse = 1;//#map:_###_obj_###_:41
                __codebox_tilde_04_burstEnv = 0;//#map:_###_obj_###_:42
                __codebox_tilde_04_tailEnv = 0;//#map:_###_obj_###_:43
                __codebox_tilde_04_tailRise = 0;//#map:_###_obj_###_:44
                __codebox_tilde_04_svfIc1 = 0;//#map:_###_obj_###_:45
                __codebox_tilde_04_svfIc2 = 0;//#map:_###_obj_###_:46
            } else if (__codebox_tilde_04_burstsLeft > 0) {
                __codebox_tilde_04_countdown -= 1;//#map:_###_obj_###_:48
    
                if (__codebox_tilde_04_countdown <= 0) {
                    __codebox_tilde_04_burstsLeft -= 1;//#map:_###_obj_###_:50
                    burstPulse = 1;//#map:_###_obj_###_:51
                }//#map:_###_obj_###_:49
            }//#map:_###_obj_###_:47//#map:_###_obj_###_:27
    
            if (burstPulse > 0) {
                __codebox_tilde_04_burstEnv = 1;//#map:_###_obj_###_:55
    
                if (__codebox_tilde_04_burstsLeft > 0) {
                    __codebox_tilde_04_scatterState = this->wrap((__codebox_tilde_04_scatterState + 1) * 16807, 0, 2147483647) - 1;//#map:_###_obj_###_:58
                    number jitter = (__codebox_tilde_04_scatterState + 1) / (number)1073741823.5 - 1;
                    number interval = this->maximum(2, __codebox_tilde_04_hitSpacing) * (1 + jitter * ((__codebox_tilde_04_hitScatter > 1 ? 1 : (__codebox_tilde_04_hitScatter < 0 ? 0 : __codebox_tilde_04_hitScatter))) * 0.45);
                    __codebox_tilde_04_countdown = this->maximum(1, rnbo_floor(interval * 0.001 * sr + 0.5));//#map:_###_obj_###_:61
                } else {
                    __codebox_tilde_04_tailEnv = 1;//#map:_###_obj_###_:64
                    __codebox_tilde_04_tailRise = 0;//#map:_###_obj_###_:65
                }//#map:_###_obj_###_:56
            }//#map:_###_obj_###_:54
    
            __codebox_tilde_04_burstEnv *= rnbo_exp(
                (this->maximum(1, __codebox_tilde_04_hitBurstDecay) * 0.001 * sr == 0. ? 0. : -6.907755 / (this->maximum(1, __codebox_tilde_04_hitBurstDecay) * 0.001 * sr))
            );//#map:_###_obj_###_:68
    
            __codebox_tilde_04_tailEnv *= rnbo_exp(
                (this->maximum(5, __codebox_tilde_04_hitTailDecay) * 0.001 * sr == 0. ? 0. : -6.907755 / (this->maximum(5, __codebox_tilde_04_hitTailDecay) * 0.001 * sr))
            );//#map:_###_obj_###_:69
    
            __codebox_tilde_04_tailRise = 1 - (1 - __codebox_tilde_04_tailRise) * rnbo_exp((0.003 * sr == 0. ? 0. : -1 / (0.003 * sr)));//#map:_###_obj_###_:70
            __codebox_tilde_04_noiseState = this->wrap((__codebox_tilde_04_noiseState + 1) * 16807, 0, 2147483647) - 1;//#map:_###_obj_###_:71
            number white = (__codebox_tilde_04_noiseState + 1) / (number)1073741823.5 - 1;
            number balance = (__codebox_tilde_04_hitBalance > 1 ? 1 : (__codebox_tilde_04_hitBalance < 0 ? 0 : __codebox_tilde_04_hitBalance));
            number excitation = white * (__codebox_tilde_04_burstEnv * (1 - balance) + __codebox_tilde_04_tailEnv * __codebox_tilde_04_tailRise * ((__codebox_tilde_04_hitTailLevel > 1 ? 1 : (__codebox_tilde_04_hitTailLevel < 0 ? 0 : __codebox_tilde_04_hitTailLevel))) * balance) * 1.8;
    
            number g = rnbo_tan(
                (sr == 0. ? 0. : 3.141592653589793 * ((__codebox_tilde_04_hitFilterHz > sr * 0.45 ? sr * 0.45 : (__codebox_tilde_04_hitFilterHz < 100 ? 100 : __codebox_tilde_04_hitFilterHz))) / sr)
            );
    
            number k = (this->maximum(0.5, __codebox_tilde_04_hitFilterQ) == 0. ? 0. : (number)1 / this->maximum(0.5, __codebox_tilde_04_hitFilterQ));
            number a1 = (1 + g * (g + k) == 0. ? 0. : (number)1 / (1 + g * (g + k)));
            number a2 = g * a1;
            number a3 = g * a2;
            number v3 = excitation - __codebox_tilde_04_svfIc2;
            number band = a1 * __codebox_tilde_04_svfIc1 + a2 * v3;
            number low = __codebox_tilde_04_svfIc2 + a2 * __codebox_tilde_04_svfIc1 + a3 * v3;
            __codebox_tilde_04_svfIc1 = 2 * band - __codebox_tilde_04_svfIc1;//#map:_###_obj_###_:85
            __codebox_tilde_04_svfIc2 = 2 * low - __codebox_tilde_04_svfIc2;//#map:_###_obj_###_:86
            number high = excitation - k * band - low;
            number brightness = (__codebox_tilde_04_hitBrightness > 1 ? 1 : (__codebox_tilde_04_hitBrightness < 0 ? 0 : __codebox_tilde_04_hitBrightness));
            number raw = band * k * (1 - brightness * 0.4) + high * brightness * 0.65;
            auto drive = this->maximum(0.25, __codebox_tilde_04_hitDrive);
            out1[(Index)i] = ((rnbo_tanh(drive) == 0. ? 0. : rnbo_tanh(raw * drive) / rnbo_tanh(drive))) * ((__codebox_tilde_04_hitLevel > 1 ? 1 : (__codebox_tilde_04_hitLevel < 0 ? 0 : __codebox_tilde_04_hitLevel)));//#map:_###_obj_###_:91
        }
    
        this->codebox_tilde_04_hitCount = __codebox_tilde_04_hitCount;
        this->codebox_tilde_04_hitScatter = __codebox_tilde_04_hitScatter;
        this->codebox_tilde_04_hitTailDecay = __codebox_tilde_04_hitTailDecay;
        this->codebox_tilde_04_hitBurstDecay = __codebox_tilde_04_hitBurstDecay;
        this->codebox_tilde_04_hitSpacing = __codebox_tilde_04_hitSpacing;
        this->codebox_tilde_04_hitFilterHz = __codebox_tilde_04_hitFilterHz;
        this->codebox_tilde_04_hitBalance = __codebox_tilde_04_hitBalance;
        this->codebox_tilde_04_hitTailLevel = __codebox_tilde_04_hitTailLevel;
        this->codebox_tilde_04_hitFilterQ = __codebox_tilde_04_hitFilterQ;
        this->codebox_tilde_04_hitBrightness = __codebox_tilde_04_hitBrightness;
        this->codebox_tilde_04_hitDrive = __codebox_tilde_04_hitDrive;
        this->codebox_tilde_04_hitLevel = __codebox_tilde_04_hitLevel;
        this->codebox_tilde_04_burstsLeft = __codebox_tilde_04_burstsLeft;
        this->codebox_tilde_04_burstEnv = __codebox_tilde_04_burstEnv;
        this->codebox_tilde_04_tailEnv = __codebox_tilde_04_tailEnv;
        this->codebox_tilde_04_tailRise = __codebox_tilde_04_tailRise;
        this->codebox_tilde_04_svfIc1 = __codebox_tilde_04_svfIc1;
        this->codebox_tilde_04_svfIc2 = __codebox_tilde_04_svfIc2;
        this->codebox_tilde_04_countdown = __codebox_tilde_04_countdown;
        this->codebox_tilde_04_scatterState = __codebox_tilde_04_scatterState;
        this->codebox_tilde_04_noiseState = __codebox_tilde_04_noiseState;
    }
    
    void dspexpr_04_perform(const Sample * in1, number in2, SampleValue * out1, Index n) {
        RNBO_UNUSED(in2);
        Index i;
    
        for (i = 0; i < (Index)n; i++) {
            out1[(Index)i] = in1[(Index)i] * 1;//#map:_###_obj_###_:1
        }
    }
    
    void signalforwarder_07_perform(const SampleValue * input, SampleValue * output, Index n) {
        copySignal(output, input, n);
    }
    
    void signalforwarder_08_perform(const SampleValue * input, SampleValue * output, Index n) {
        copySignal(output, input, n);
    }
    
    void stackprotect_perform(Index n) {
        RNBO_UNUSED(n);
        auto __stackprotect_count = this->stackprotect_count;
        __stackprotect_count = 0;
        this->stackprotect_count = __stackprotect_count;
    }
    
    void ip_37_init() {
        this->ip_37_lastValue = this->ip_37_value;
    }
    
    void ip_37_fillSigBuf() {
        if ((bool)(this->ip_37_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_37_lastIndex); i < k; i++) {
                if (this->ip_37_resetCount > 0) {
                    this->ip_37_sigbuf[(Index)i] = 1;
                    this->ip_37_resetCount--;
                } else {
                    this->ip_37_sigbuf[(Index)i] = this->ip_37_lastValue;
                }
            }
    
            this->ip_37_lastIndex = k;
        }
    }
    
    void ip_37_dspsetup(bool force) {
        if ((bool)(this->ip_37_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_37_lastIndex = 0;
        this->ip_37_setupDone = true;
    }
    
    void ip_38_init() {
        this->ip_38_lastValue = this->ip_38_value;
    }
    
    void ip_38_fillSigBuf() {
        if ((bool)(this->ip_38_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_38_lastIndex); i < k; i++) {
                if (this->ip_38_resetCount > 0) {
                    this->ip_38_sigbuf[(Index)i] = 1;
                    this->ip_38_resetCount--;
                } else {
                    this->ip_38_sigbuf[(Index)i] = this->ip_38_lastValue;
                }
            }
    
            this->ip_38_lastIndex = k;
        }
    }
    
    void ip_38_dspsetup(bool force) {
        if ((bool)(this->ip_38_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_38_lastIndex = 0;
        this->ip_38_setupDone = true;
    }
    
    void ip_39_init() {
        this->ip_39_lastValue = this->ip_39_value;
    }
    
    void ip_39_fillSigBuf() {
        if ((bool)(this->ip_39_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_39_lastIndex); i < k; i++) {
                if (this->ip_39_resetCount > 0) {
                    this->ip_39_sigbuf[(Index)i] = 1;
                    this->ip_39_resetCount--;
                } else {
                    this->ip_39_sigbuf[(Index)i] = this->ip_39_lastValue;
                }
            }
    
            this->ip_39_lastIndex = k;
        }
    }
    
    void ip_39_dspsetup(bool force) {
        if ((bool)(this->ip_39_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_39_lastIndex = 0;
        this->ip_39_setupDone = true;
    }
    
    void ip_40_init() {
        this->ip_40_lastValue = this->ip_40_value;
    }
    
    void ip_40_fillSigBuf() {
        if ((bool)(this->ip_40_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_40_lastIndex); i < k; i++) {
                if (this->ip_40_resetCount > 0) {
                    this->ip_40_sigbuf[(Index)i] = 1;
                    this->ip_40_resetCount--;
                } else {
                    this->ip_40_sigbuf[(Index)i] = this->ip_40_lastValue;
                }
            }
    
            this->ip_40_lastIndex = k;
        }
    }
    
    void ip_40_dspsetup(bool force) {
        if ((bool)(this->ip_40_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_40_lastIndex = 0;
        this->ip_40_setupDone = true;
    }
    
    void ip_41_init() {
        this->ip_41_lastValue = this->ip_41_value;
    }
    
    void ip_41_fillSigBuf() {
        if ((bool)(this->ip_41_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_41_lastIndex); i < k; i++) {
                if (this->ip_41_resetCount > 0) {
                    this->ip_41_sigbuf[(Index)i] = 1;
                    this->ip_41_resetCount--;
                } else {
                    this->ip_41_sigbuf[(Index)i] = this->ip_41_lastValue;
                }
            }
    
            this->ip_41_lastIndex = k;
        }
    }
    
    void ip_41_dspsetup(bool force) {
        if ((bool)(this->ip_41_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_41_lastIndex = 0;
        this->ip_41_setupDone = true;
    }
    
    void ip_42_init() {
        this->ip_42_lastValue = this->ip_42_value;
    }
    
    void ip_42_fillSigBuf() {
        if ((bool)(this->ip_42_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_42_lastIndex); i < k; i++) {
                if (this->ip_42_resetCount > 0) {
                    this->ip_42_sigbuf[(Index)i] = 1;
                    this->ip_42_resetCount--;
                } else {
                    this->ip_42_sigbuf[(Index)i] = this->ip_42_lastValue;
                }
            }
    
            this->ip_42_lastIndex = k;
        }
    }
    
    void ip_42_dspsetup(bool force) {
        if ((bool)(this->ip_42_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_42_lastIndex = 0;
        this->ip_42_setupDone = true;
    }
    
    void ip_43_init() {
        this->ip_43_lastValue = this->ip_43_value;
    }
    
    void ip_43_fillSigBuf() {
        if ((bool)(this->ip_43_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_43_lastIndex); i < k; i++) {
                if (this->ip_43_resetCount > 0) {
                    this->ip_43_sigbuf[(Index)i] = 1;
                    this->ip_43_resetCount--;
                } else {
                    this->ip_43_sigbuf[(Index)i] = this->ip_43_lastValue;
                }
            }
    
            this->ip_43_lastIndex = k;
        }
    }
    
    void ip_43_dspsetup(bool force) {
        if ((bool)(this->ip_43_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_43_lastIndex = 0;
        this->ip_43_setupDone = true;
    }
    
    void ip_44_init() {
        this->ip_44_lastValue = this->ip_44_value;
    }
    
    void ip_44_fillSigBuf() {
        if ((bool)(this->ip_44_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_44_lastIndex); i < k; i++) {
                if (this->ip_44_resetCount > 0) {
                    this->ip_44_sigbuf[(Index)i] = 1;
                    this->ip_44_resetCount--;
                } else {
                    this->ip_44_sigbuf[(Index)i] = this->ip_44_lastValue;
                }
            }
    
            this->ip_44_lastIndex = k;
        }
    }
    
    void ip_44_dspsetup(bool force) {
        if ((bool)(this->ip_44_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_44_lastIndex = 0;
        this->ip_44_setupDone = true;
    }
    
    void ip_45_init() {
        this->ip_45_lastValue = this->ip_45_value;
    }
    
    void ip_45_fillSigBuf() {
        if ((bool)(this->ip_45_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_45_lastIndex); i < k; i++) {
                if (this->ip_45_resetCount > 0) {
                    this->ip_45_sigbuf[(Index)i] = 1;
                    this->ip_45_resetCount--;
                } else {
                    this->ip_45_sigbuf[(Index)i] = this->ip_45_lastValue;
                }
            }
    
            this->ip_45_lastIndex = k;
        }
    }
    
    void ip_45_dspsetup(bool force) {
        if ((bool)(this->ip_45_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_45_lastIndex = 0;
        this->ip_45_setupDone = true;
    }
    
    void ip_46_init() {
        this->ip_46_lastValue = this->ip_46_value;
    }
    
    void ip_46_fillSigBuf() {
        if ((bool)(this->ip_46_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_46_lastIndex); i < k; i++) {
                if (this->ip_46_resetCount > 0) {
                    this->ip_46_sigbuf[(Index)i] = 1;
                    this->ip_46_resetCount--;
                } else {
                    this->ip_46_sigbuf[(Index)i] = this->ip_46_lastValue;
                }
            }
    
            this->ip_46_lastIndex = k;
        }
    }
    
    void ip_46_dspsetup(bool force) {
        if ((bool)(this->ip_46_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_46_lastIndex = 0;
        this->ip_46_setupDone = true;
    }
    
    void ip_47_init() {
        this->ip_47_lastValue = this->ip_47_value;
    }
    
    void ip_47_fillSigBuf() {
        if ((bool)(this->ip_47_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_47_lastIndex); i < k; i++) {
                if (this->ip_47_resetCount > 0) {
                    this->ip_47_sigbuf[(Index)i] = 1;
                    this->ip_47_resetCount--;
                } else {
                    this->ip_47_sigbuf[(Index)i] = this->ip_47_lastValue;
                }
            }
    
            this->ip_47_lastIndex = k;
        }
    }
    
    void ip_47_dspsetup(bool force) {
        if ((bool)(this->ip_47_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_47_lastIndex = 0;
        this->ip_47_setupDone = true;
    }
    
    void ip_48_init() {
        this->ip_48_lastValue = this->ip_48_value;
    }
    
    void ip_48_fillSigBuf() {
        if ((bool)(this->ip_48_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_48_lastIndex); i < k; i++) {
                if (this->ip_48_resetCount > 0) {
                    this->ip_48_sigbuf[(Index)i] = 1;
                    this->ip_48_resetCount--;
                } else {
                    this->ip_48_sigbuf[(Index)i] = this->ip_48_lastValue;
                }
            }
    
            this->ip_48_lastIndex = k;
        }
    }
    
    void ip_48_dspsetup(bool force) {
        if ((bool)(this->ip_48_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_48_lastIndex = 0;
        this->ip_48_setupDone = true;
    }
    
    bool stackprotect_check() {
        this->stackprotect_count++;
    
        if (this->stackprotect_count > 128) {
            console->log("STACK OVERFLOW DETECTED - stopped processing branch !");
            return true;
        }
    
        return false;
    }
    
    Index getPatcherSerial() const {
        return 0;
    }
    
    void sendParameter(ParameterIndex index, bool ignoreValue) {
        this->getPatcher()->sendParameter(index + this->parameterOffset, ignoreValue);
    }
    
    void scheduleParamInit(ParameterIndex index, Index order) {
        this->getPatcher()->scheduleParamInit(index + this->parameterOffset, order);
    }
    
    void updateTime(MillisecondTime time, EXTERNALENGINE* engine, bool inProcess = false) {
        RNBO_UNUSED(inProcess);
        RNBO_UNUSED(engine);
        this->_currentTime = time;
        auto offset = rnbo_fround(this->msToSamps(time - this->getEngine()->getCurrentTime(), this->sr));
    
        if (offset >= (SampleIndex)(this->vs))
            offset = (SampleIndex)(this->vs) - 1;
    
        if (offset < 0)
            offset = 0;
    
        this->sampleOffsetIntoNextAudioBuffer = (Index)(offset);
    }
    
    void assign_defaults()
    {
        ip_37_value = 0;
        ip_37_impulse = 0;
        ip_38_value = 0;
        ip_38_impulse = 0;
        ip_39_value = 0;
        ip_39_impulse = 0;
        ip_40_value = 0;
        ip_40_impulse = 0;
        ip_41_value = 0;
        ip_41_impulse = 0;
        ip_42_value = 0;
        ip_42_impulse = 0;
        ip_43_value = 0;
        ip_43_impulse = 0;
        ip_44_value = 0;
        ip_44_impulse = 0;
        ip_45_value = 0;
        ip_45_impulse = 0;
        ip_46_value = 0;
        ip_46_impulse = 0;
        ip_47_value = 0;
        ip_47_impulse = 0;
        ip_48_value = 0;
        ip_48_impulse = 0;
        codebox_tilde_04_in1 = 0;
        codebox_tilde_04_in2 = 0;
        codebox_tilde_04_in3 = 0;
        codebox_tilde_04_in4 = 0;
        codebox_tilde_04_in5 = 0;
        codebox_tilde_04_in6 = 0;
        codebox_tilde_04_in7 = 0;
        codebox_tilde_04_in8 = 0;
        codebox_tilde_04_in9 = 0;
        codebox_tilde_04_in10 = 0;
        codebox_tilde_04_in11 = 0;
        codebox_tilde_04_in12 = 0;
        codebox_tilde_04_in13 = 0;
        dspexpr_04_in1 = 0;
        dspexpr_04_in2 = 1;
        _currentTime = 0;
        audioProcessSampleCount = 0;
        sampleOffsetIntoNextAudioBuffer = 0;
        zeroBuffer = nullptr;
        dummyBuffer = nullptr;
        signals[0] = nullptr;
        signals[1] = nullptr;
        signals[2] = nullptr;
        signals[3] = nullptr;
        signals[4] = nullptr;
        signals[5] = nullptr;
        signals[6] = nullptr;
        signals[7] = nullptr;
        signals[8] = nullptr;
        signals[9] = nullptr;
        signals[10] = nullptr;
        signals[11] = nullptr;
        signals[12] = nullptr;
        signals[13] = nullptr;
        didAllocateSignals = 0;
        vs = 0;
        maxvs = 0;
        sr = 44100;
        invsr = 0.000022675736961451248;
        click_04_lastclick = -1;
        click_04_buf = nullptr;
        ip_37_lastIndex = 0;
        ip_37_lastValue = 0;
        ip_37_resetCount = 0;
        ip_37_sigbuf = nullptr;
        ip_37_setupDone = false;
        ip_38_lastIndex = 0;
        ip_38_lastValue = 0;
        ip_38_resetCount = 0;
        ip_38_sigbuf = nullptr;
        ip_38_setupDone = false;
        ip_39_lastIndex = 0;
        ip_39_lastValue = 0;
        ip_39_resetCount = 0;
        ip_39_sigbuf = nullptr;
        ip_39_setupDone = false;
        ip_40_lastIndex = 0;
        ip_40_lastValue = 0;
        ip_40_resetCount = 0;
        ip_40_sigbuf = nullptr;
        ip_40_setupDone = false;
        ip_41_lastIndex = 0;
        ip_41_lastValue = 0;
        ip_41_resetCount = 0;
        ip_41_sigbuf = nullptr;
        ip_41_setupDone = false;
        ip_42_lastIndex = 0;
        ip_42_lastValue = 0;
        ip_42_resetCount = 0;
        ip_42_sigbuf = nullptr;
        ip_42_setupDone = false;
        ip_43_lastIndex = 0;
        ip_43_lastValue = 0;
        ip_43_resetCount = 0;
        ip_43_sigbuf = nullptr;
        ip_43_setupDone = false;
        ip_44_lastIndex = 0;
        ip_44_lastValue = 0;
        ip_44_resetCount = 0;
        ip_44_sigbuf = nullptr;
        ip_44_setupDone = false;
        ip_45_lastIndex = 0;
        ip_45_lastValue = 0;
        ip_45_resetCount = 0;
        ip_45_sigbuf = nullptr;
        ip_45_setupDone = false;
        ip_46_lastIndex = 0;
        ip_46_lastValue = 0;
        ip_46_resetCount = 0;
        ip_46_sigbuf = nullptr;
        ip_46_setupDone = false;
        ip_47_lastIndex = 0;
        ip_47_lastValue = 0;
        ip_47_resetCount = 0;
        ip_47_sigbuf = nullptr;
        ip_47_setupDone = false;
        ip_48_lastIndex = 0;
        ip_48_lastValue = 0;
        ip_48_resetCount = 0;
        ip_48_sigbuf = nullptr;
        ip_48_setupDone = false;
        codebox_tilde_04_hitCount = 3;
        codebox_tilde_04_hitScatter = 0.15;
        codebox_tilde_04_hitTailDecay = 280;
        codebox_tilde_04_hitBurstDecay = 10;
        codebox_tilde_04_hitSpacing = 12;
        codebox_tilde_04_hitFilterHz = 1600;
        codebox_tilde_04_hitBalance = 0.45;
        codebox_tilde_04_hitTailLevel = 0.65;
        codebox_tilde_04_hitFilterQ = 1.1;
        codebox_tilde_04_hitBrightness = 0.2;
        codebox_tilde_04_hitDrive = 1.5;
        codebox_tilde_04_hitLevel = 0.5;
        codebox_tilde_04_burstsLeft = 0;
        codebox_tilde_04_countdown = 0;
        codebox_tilde_04_burstEnv = 0;
        codebox_tilde_04_tailEnv = 0;
        codebox_tilde_04_tailRise = 0;
        codebox_tilde_04_noiseState = 12344;
        codebox_tilde_04_scatterState = 54320;
        codebox_tilde_04_svfIc1 = 0;
        codebox_tilde_04_svfIc2 = 0;
        stackprotect_count = 0;
        _voiceIndex = 0;
        _noteNumber = 0;
        isMuted = 1;
        parameterOffset = 0;
    }
    
    // member variables
    
        number ip_37_value;
        number ip_37_impulse;
        number ip_38_value;
        number ip_38_impulse;
        number ip_39_value;
        number ip_39_impulse;
        number ip_40_value;
        number ip_40_impulse;
        number ip_41_value;
        number ip_41_impulse;
        number ip_42_value;
        number ip_42_impulse;
        number ip_43_value;
        number ip_43_impulse;
        number ip_44_value;
        number ip_44_impulse;
        number ip_45_value;
        number ip_45_impulse;
        number ip_46_value;
        number ip_46_impulse;
        number ip_47_value;
        number ip_47_impulse;
        number ip_48_value;
        number ip_48_impulse;
        number codebox_tilde_04_in1;
        number codebox_tilde_04_in2;
        number codebox_tilde_04_in3;
        number codebox_tilde_04_in4;
        number codebox_tilde_04_in5;
        number codebox_tilde_04_in6;
        number codebox_tilde_04_in7;
        number codebox_tilde_04_in8;
        number codebox_tilde_04_in9;
        number codebox_tilde_04_in10;
        number codebox_tilde_04_in11;
        number codebox_tilde_04_in12;
        number codebox_tilde_04_in13;
        number dspexpr_04_in1;
        number dspexpr_04_in2;
        MillisecondTime _currentTime;
        UInt64 audioProcessSampleCount;
        Index sampleOffsetIntoNextAudioBuffer;
        signal zeroBuffer;
        signal dummyBuffer;
        SampleValue * signals[14];
        bool didAllocateSignals;
        Index vs;
        Index maxvs;
        number sr;
        number invsr;
        SampleIndex click_04_lastclick;
        signal click_04_buf;
        SampleIndex ip_37_lastIndex;
        number ip_37_lastValue;
        SampleIndex ip_37_resetCount;
        signal ip_37_sigbuf;
        bool ip_37_setupDone;
        SampleIndex ip_38_lastIndex;
        number ip_38_lastValue;
        SampleIndex ip_38_resetCount;
        signal ip_38_sigbuf;
        bool ip_38_setupDone;
        SampleIndex ip_39_lastIndex;
        number ip_39_lastValue;
        SampleIndex ip_39_resetCount;
        signal ip_39_sigbuf;
        bool ip_39_setupDone;
        SampleIndex ip_40_lastIndex;
        number ip_40_lastValue;
        SampleIndex ip_40_resetCount;
        signal ip_40_sigbuf;
        bool ip_40_setupDone;
        SampleIndex ip_41_lastIndex;
        number ip_41_lastValue;
        SampleIndex ip_41_resetCount;
        signal ip_41_sigbuf;
        bool ip_41_setupDone;
        SampleIndex ip_42_lastIndex;
        number ip_42_lastValue;
        SampleIndex ip_42_resetCount;
        signal ip_42_sigbuf;
        bool ip_42_setupDone;
        SampleIndex ip_43_lastIndex;
        number ip_43_lastValue;
        SampleIndex ip_43_resetCount;
        signal ip_43_sigbuf;
        bool ip_43_setupDone;
        SampleIndex ip_44_lastIndex;
        number ip_44_lastValue;
        SampleIndex ip_44_resetCount;
        signal ip_44_sigbuf;
        bool ip_44_setupDone;
        SampleIndex ip_45_lastIndex;
        number ip_45_lastValue;
        SampleIndex ip_45_resetCount;
        signal ip_45_sigbuf;
        bool ip_45_setupDone;
        SampleIndex ip_46_lastIndex;
        number ip_46_lastValue;
        SampleIndex ip_46_resetCount;
        signal ip_46_sigbuf;
        bool ip_46_setupDone;
        SampleIndex ip_47_lastIndex;
        number ip_47_lastValue;
        SampleIndex ip_47_resetCount;
        signal ip_47_sigbuf;
        bool ip_47_setupDone;
        SampleIndex ip_48_lastIndex;
        number ip_48_lastValue;
        SampleIndex ip_48_resetCount;
        signal ip_48_sigbuf;
        bool ip_48_setupDone;
        number codebox_tilde_04_hitCount;
        number codebox_tilde_04_hitScatter;
        number codebox_tilde_04_hitTailDecay;
        number codebox_tilde_04_hitBurstDecay;
        number codebox_tilde_04_hitSpacing;
        number codebox_tilde_04_hitFilterHz;
        number codebox_tilde_04_hitBalance;
        number codebox_tilde_04_hitTailLevel;
        number codebox_tilde_04_hitFilterQ;
        number codebox_tilde_04_hitBrightness;
        number codebox_tilde_04_hitDrive;
        number codebox_tilde_04_hitLevel;
        number codebox_tilde_04_burstsLeft;
        number codebox_tilde_04_countdown;
        number codebox_tilde_04_burstEnv;
        number codebox_tilde_04_tailEnv;
        number codebox_tilde_04_tailRise;
        number codebox_tilde_04_noiseState;
        number codebox_tilde_04_scatterState;
        number codebox_tilde_04_svfIc1;
        number codebox_tilde_04_svfIc2;
        number stackprotect_count;
        Index _voiceIndex;
        Int _noteNumber;
        Index isMuted;
        ParameterIndex parameterOffset;
        bool _isInitialized = false;
};

class RNBOSubpatcher_122 : public PatcherInterfaceImpl {
    
    friend class rnbomatic;
    
    public:
    
    RNBOSubpatcher_122()
    {}
    
    ~RNBOSubpatcher_122()
    {
        deallocateSignals();
    }
    
    Index getNumMidiInputPorts() const {
        return 0;
    }
    
    void processMidiEvent(MillisecondTime , int , ConstByteArray , Index ) {}
    
    Index getNumMidiOutputPorts() const {
        return 0;
    }
    
    void process(
        const SampleValue * const* inputs,
        Index numInputs,
        SampleValue * const* outputs,
        Index numOutputs,
        Index n
    ) {
        RNBO_UNUSED(numInputs);
        RNBO_UNUSED(inputs);
        this->vs = n;
        this->updateTime(this->getEngine()->getCurrentTime(), (ENGINE*)nullptr, true);
        SampleValue * out1 = (numOutputs >= 1 && outputs[0] ? outputs[0] : this->dummyBuffer);
        SampleValue * out2 = (numOutputs >= 2 && outputs[1] ? outputs[1] : this->dummyBuffer);
        this->click_05_perform(this->signals[0], n);
        this->ip_49_perform(this->signals[1], n);
        this->ip_50_perform(this->signals[2], n);
        this->ip_51_perform(this->signals[3], n);
        this->ip_52_perform(this->signals[4], n);
        this->ip_53_perform(this->signals[5], n);
        this->ip_54_perform(this->signals[6], n);
        this->ip_55_perform(this->signals[7], n);
        this->ip_56_perform(this->signals[8], n);
        this->ip_57_perform(this->signals[9], n);
        this->ip_58_perform(this->signals[10], n);
        this->ip_59_perform(this->signals[11], n);
        this->ip_60_perform(this->signals[12], n);
    
        this->codebox_tilde_05_perform(
            this->signals[0],
            this->signals[1],
            this->signals[2],
            this->signals[3],
            this->signals[4],
            this->signals[5],
            this->signals[6],
            this->signals[7],
            this->signals[8],
            this->signals[9],
            this->signals[10],
            this->signals[11],
            this->signals[12],
            this->signals[13],
            n
        );
    
        this->dspexpr_05_perform(this->signals[13], this->dspexpr_05_in2, this->signals[12], n);
        this->signalforwarder_09_perform(this->signals[12], out2, n);
        this->signalforwarder_10_perform(this->signals[12], out1, n);
        this->stackprotect_perform(n);
        this->audioProcessSampleCount += this->vs;
    }
    
    void prepareToProcess(number sampleRate, Index maxBlockSize, bool force) {
        RNBO_ASSERT(this->_isInitialized);
    
        if (this->maxvs < maxBlockSize || !this->didAllocateSignals) {
            Index i;
    
            for (i = 0; i < 14; i++) {
                this->signals[i] = resizeSignal(this->signals[i], this->maxvs, maxBlockSize);
            }
    
            this->click_05_buf = resizeSignal(this->click_05_buf, this->maxvs, maxBlockSize);
            this->ip_49_sigbuf = resizeSignal(this->ip_49_sigbuf, this->maxvs, maxBlockSize);
            this->ip_50_sigbuf = resizeSignal(this->ip_50_sigbuf, this->maxvs, maxBlockSize);
            this->ip_51_sigbuf = resizeSignal(this->ip_51_sigbuf, this->maxvs, maxBlockSize);
            this->ip_52_sigbuf = resizeSignal(this->ip_52_sigbuf, this->maxvs, maxBlockSize);
            this->ip_53_sigbuf = resizeSignal(this->ip_53_sigbuf, this->maxvs, maxBlockSize);
            this->ip_54_sigbuf = resizeSignal(this->ip_54_sigbuf, this->maxvs, maxBlockSize);
            this->ip_55_sigbuf = resizeSignal(this->ip_55_sigbuf, this->maxvs, maxBlockSize);
            this->ip_56_sigbuf = resizeSignal(this->ip_56_sigbuf, this->maxvs, maxBlockSize);
            this->ip_57_sigbuf = resizeSignal(this->ip_57_sigbuf, this->maxvs, maxBlockSize);
            this->ip_58_sigbuf = resizeSignal(this->ip_58_sigbuf, this->maxvs, maxBlockSize);
            this->ip_59_sigbuf = resizeSignal(this->ip_59_sigbuf, this->maxvs, maxBlockSize);
            this->ip_60_sigbuf = resizeSignal(this->ip_60_sigbuf, this->maxvs, maxBlockSize);
            this->zeroBuffer = resizeSignal(this->zeroBuffer, this->maxvs, maxBlockSize);
            this->dummyBuffer = resizeSignal(this->dummyBuffer, this->maxvs, maxBlockSize);
            this->didAllocateSignals = true;
        }
    
        const bool sampleRateChanged = sampleRate != this->sr;
        const bool maxvsChanged = maxBlockSize != this->maxvs;
        const bool forceDSPSetup = sampleRateChanged || maxvsChanged || force;
    
        if (sampleRateChanged || maxvsChanged) {
            this->vs = maxBlockSize;
            this->maxvs = maxBlockSize;
            this->sr = sampleRate;
            this->invsr = 1 / sampleRate;
        }
    
        this->ip_49_dspsetup(forceDSPSetup);
        this->ip_50_dspsetup(forceDSPSetup);
        this->ip_51_dspsetup(forceDSPSetup);
        this->ip_52_dspsetup(forceDSPSetup);
        this->ip_53_dspsetup(forceDSPSetup);
        this->ip_54_dspsetup(forceDSPSetup);
        this->ip_55_dspsetup(forceDSPSetup);
        this->ip_56_dspsetup(forceDSPSetup);
        this->ip_57_dspsetup(forceDSPSetup);
        this->ip_58_dspsetup(forceDSPSetup);
        this->ip_59_dspsetup(forceDSPSetup);
        this->ip_60_dspsetup(forceDSPSetup);
    
        if (sampleRateChanged)
            this->onSampleRateChanged(sampleRate);
    }
    
    number msToSamps(MillisecondTime ms, number sampleRate) {
        return ms * sampleRate * 0.001;
    }
    
    MillisecondTime sampsToMs(SampleIndex samps) {
        return samps * (this->invsr * 1000);
    }
    
    Index getNumInputChannels() const {
        return 0;
    }
    
    Index getNumOutputChannels() const {
        return 2;
    }
    
    void getPreset(PatcherStateInterface& ) {}
    
    void setPreset(MillisecondTime , PatcherStateInterface& ) {}
    
    void setParameterValue(ParameterIndex , ParameterValue , MillisecondTime ) {}
    
    void processParameterEvent(ParameterIndex index, ParameterValue value, MillisecondTime time) {
        this->setParameterValue(index, value, time);
    }
    
    void processParameterBangEvent(ParameterIndex index, MillisecondTime time) {
        this->setParameterValue(index, this->getParameterValue(index), time);
    }
    
    void processNormalizedParameterEvent(ParameterIndex index, ParameterValue value, MillisecondTime time) {
        this->setParameterValueNormalized(index, value, time);
    }
    
    ParameterValue getParameterValue(ParameterIndex index)  {
        switch (index) {
        default:
            {
            return 0;
            }
        }
    }
    
    ParameterIndex getNumSignalInParameters() const {
        return 0;
    }
    
    ParameterIndex getNumSignalOutParameters() const {
        return 0;
    }
    
    ParameterIndex getNumParameters() const {
        return 0;
    }
    
    ConstCharPointer getParameterName(ParameterIndex index) const {
        switch (index) {
        default:
            {
            return "bogus";
            }
        }
    }
    
    ConstCharPointer getParameterId(ParameterIndex index) const {
        switch (index) {
        default:
            {
            return "bogus";
            }
        }
    }
    
    void getParameterInfo(ParameterIndex , ParameterInfo * ) const {}
    
    ParameterValue applyStepsToNormalizedParameterValue(ParameterValue normalizedValue, int steps) const {
        if (steps == 1) {
            if (normalizedValue > 0) {
                normalizedValue = 1.;
            }
        } else {
            ParameterValue oneStep = (number)1. / (steps - 1);
            ParameterValue numberOfSteps = rnbo_fround(normalizedValue / oneStep * 1 / (number)1) * (number)1;
            normalizedValue = numberOfSteps * oneStep;
        }
    
        return normalizedValue;
    }
    
    ParameterValue convertToNormalizedParameterValue(ParameterIndex index, ParameterValue value) const {
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    ParameterValue convertFromNormalizedParameterValue(ParameterIndex index, ParameterValue value) const {
        value = (value < 0 ? 0 : (value > 1 ? 1 : value));
    
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    ParameterValue constrainParameterValue(ParameterIndex index, ParameterValue value) const {
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    void processNumMessage(MessageTag , MessageTag , MillisecondTime , number ) {}
    
    void processListMessage(MessageTag , MessageTag , MillisecondTime , const list& ) {}
    
    void processBangMessage(MessageTag , MessageTag , MillisecondTime ) {}
    
    MessageTagInfo resolveTag(MessageTag tag) const {
        switch (tag) {
    
        }
    
        return nullptr;
    }
    
    DataRef* getDataRef(DataRefIndex index)  {
        switch (index) {
        default:
            {
            return nullptr;
            }
        }
    }
    
    DataRefIndex getNumDataRefs() const {
        return 0;
    }
    
    void processDataViewUpdate(DataRefIndex , MillisecondTime ) {}
    
    void initialize() {
        RNBO_ASSERT(!this->_isInitialized);
        this->assign_defaults();
        this->applyState();
        this->_isInitialized = true;
    }
    
    protected:
    
    void updateTime(MillisecondTime time, INTERNALENGINE*, bool inProcess = false) {
    	if (time == TimeNow) time = getTopLevelPatcher()->getPatcherTime();
    	getTopLevelPatcher()->processInternalEvents(time);
    	updateTime(time, (EXTERNALENGINE*)nullptr);
    }
    
    RNBOSubpatcher_122* operator->() {
        return this;
    }
    const RNBOSubpatcher_122* operator->() const {
        return this;
    }
    virtual rnbomatic* getPatcher() const {
        return static_cast<rnbomatic *>(_parentPatcher);
    }
    
    rnbomatic* getTopLevelPatcher() {
        return this->getPatcher()->getTopLevelPatcher();
    }
    
    void cancelClockEvents()
    {
    }
    
    number maximum(number x, number y) {
        return (x < y ? y : x);
    }
    
    number wrap(number x, number low, number high) {
        number lo;
        number hi;
    
        if (low == high)
            return low;
    
        if (low > high) {
            hi = low;
            lo = high;
        } else {
            lo = low;
            hi = high;
        }
    
        number range = hi - lo;
    
        if (x >= lo && x < hi)
            return x;
    
        if (range <= 0.000000001)
            return lo;
    
        Int numWraps = (Int)(trunc((x - lo) / range));
        numWraps = numWraps - ((x < lo ? 1 : 0));
        number result = x - range * numWraps;
    
        if (result >= hi)
            return result - range;
        else
            return result;
    }
    
    number minimum(number x, number y) {
        return (y < x ? y : x);
    }
    
    MillisecondTime getPatcherTime() const {
        return this->_currentTime;
    }
    
    void eventinlet_54_out1_bang_bang() {
        this->ip_49_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_54_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_49_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_49_value_set(converted);
        }
    }
    
    void eventinlet_55_out1_bang_bang() {
        this->ip_50_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_55_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_50_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_50_value_set(converted);
        }
    }
    
    void eventinlet_56_out1_bang_bang() {
        this->ip_51_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_56_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_51_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_51_value_set(converted);
        }
    }
    
    void eventinlet_57_out1_bang_bang() {
        this->ip_52_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_57_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_52_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_52_value_set(converted);
        }
    }
    
    void eventinlet_58_out1_bang_bang() {
        this->ip_53_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_58_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_53_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_53_value_set(converted);
        }
    }
    
    void eventinlet_59_out1_bang_bang() {
        this->ip_54_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_59_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_54_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_54_value_set(converted);
        }
    }
    
    void eventinlet_60_out1_bang_bang() {
        this->ip_55_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_60_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_55_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_55_value_set(converted);
        }
    }
    
    void eventinlet_61_out1_bang_bang() {
        this->ip_56_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_61_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_56_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_56_value_set(converted);
        }
    }
    
    void eventinlet_62_out1_bang_bang() {
        this->ip_57_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_62_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_57_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_57_value_set(converted);
        }
    }
    
    void eventinlet_63_out1_bang_bang() {
        this->ip_58_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_63_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_58_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_58_value_set(converted);
        }
    }
    
    void eventinlet_64_out1_bang_bang() {
        this->ip_59_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_64_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_59_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_59_value_set(converted);
        }
    }
    
    void eventinlet_65_out1_bang_bang() {
        this->ip_60_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_65_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_60_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_60_value_set(converted);
        }
    }
    
    void deallocateSignals() {
        Index i;
    
        for (i = 0; i < 14; i++) {
            this->signals[i] = freeSignal(this->signals[i]);
        }
    
        this->click_05_buf = freeSignal(this->click_05_buf);
        this->ip_49_sigbuf = freeSignal(this->ip_49_sigbuf);
        this->ip_50_sigbuf = freeSignal(this->ip_50_sigbuf);
        this->ip_51_sigbuf = freeSignal(this->ip_51_sigbuf);
        this->ip_52_sigbuf = freeSignal(this->ip_52_sigbuf);
        this->ip_53_sigbuf = freeSignal(this->ip_53_sigbuf);
        this->ip_54_sigbuf = freeSignal(this->ip_54_sigbuf);
        this->ip_55_sigbuf = freeSignal(this->ip_55_sigbuf);
        this->ip_56_sigbuf = freeSignal(this->ip_56_sigbuf);
        this->ip_57_sigbuf = freeSignal(this->ip_57_sigbuf);
        this->ip_58_sigbuf = freeSignal(this->ip_58_sigbuf);
        this->ip_59_sigbuf = freeSignal(this->ip_59_sigbuf);
        this->ip_60_sigbuf = freeSignal(this->ip_60_sigbuf);
        this->zeroBuffer = freeSignal(this->zeroBuffer);
        this->dummyBuffer = freeSignal(this->dummyBuffer);
    }
    
    Index getMaxBlockSize() const {
        return this->maxvs;
    }
    
    number getSampleRate() const {
        return this->sr;
    }
    
    bool hasFixedVectorSize() const {
        return false;
    }
    
    void setProbingTarget(MessageTag ) {}
    
    void initializeObjects() {
        this->ip_49_init();
        this->ip_50_init();
        this->ip_51_init();
        this->ip_52_init();
        this->ip_53_init();
        this->ip_54_init();
        this->ip_55_init();
        this->ip_56_init();
        this->ip_57_init();
        this->ip_58_init();
        this->ip_59_init();
        this->ip_60_init();
    }
    
    Index getIsMuted()  {
        return this->isMuted;
    }
    
    void setIsMuted(Index v)  {
        this->isMuted = v;
    }
    
    void onSampleRateChanged(double ) {}
    
    void extractState(PatcherStateInterface& ) {}
    
    void applyState() {}
    
    void setParameterOffset(ParameterIndex offset) {
        this->parameterOffset = offset;
    }
    
    void processClockEvent(MillisecondTime , ClockId , bool , ParameterValue ) {}
    
    void processOutletAtCurrentTime(EngineLink* , OutletIndex , ParameterValue ) {}
    
    void processOutletEvent(
        EngineLink* sender,
        OutletIndex index,
        ParameterValue value,
        MillisecondTime time
    ) {
        this->updateTime(time, (ENGINE*)nullptr);
        this->processOutletAtCurrentTime(sender, index, value);
    }
    
    void sendOutlet(OutletIndex index, ParameterValue value) {
        this->getEngine()->sendOutlet(this, index, value);
    }
    
    void startup() {}
    
    void fillDataRef(DataRefIndex , DataRef& ) {}
    
    void allocateDataRefs() {}
    
    void ip_49_value_set(number v) {
        this->ip_49_value = v;
        this->ip_49_fillSigBuf();
        this->ip_49_lastValue = v;
    }
    
    void eventinlet_54_out1_number_set(number v) {
        this->ip_49_value_set(v);
    }
    
    void ip_52_value_set(number v) {
        this->ip_52_value = v;
        this->ip_52_fillSigBuf();
        this->ip_52_lastValue = v;
    }
    
    void eventinlet_57_out1_number_set(number v) {
        this->ip_52_value_set(v);
    }
    
    void ip_53_value_set(number v) {
        this->ip_53_value = v;
        this->ip_53_fillSigBuf();
        this->ip_53_lastValue = v;
    }
    
    void eventinlet_58_out1_number_set(number v) {
        this->ip_53_value_set(v);
    }
    
    void ip_50_value_set(number v) {
        this->ip_50_value = v;
        this->ip_50_fillSigBuf();
        this->ip_50_lastValue = v;
    }
    
    void eventinlet_55_out1_number_set(number v) {
        this->ip_50_value_set(v);
    }
    
    void ip_51_value_set(number v) {
        this->ip_51_value = v;
        this->ip_51_fillSigBuf();
        this->ip_51_lastValue = v;
    }
    
    void eventinlet_56_out1_number_set(number v) {
        this->ip_51_value_set(v);
    }
    
    void ip_54_value_set(number v) {
        this->ip_54_value = v;
        this->ip_54_fillSigBuf();
        this->ip_54_lastValue = v;
    }
    
    void eventinlet_59_out1_number_set(number v) {
        this->ip_54_value_set(v);
    }
    
    void ip_57_value_set(number v) {
        this->ip_57_value = v;
        this->ip_57_fillSigBuf();
        this->ip_57_lastValue = v;
    }
    
    void eventinlet_62_out1_number_set(number v) {
        this->ip_57_value_set(v);
    }
    
    void ip_58_value_set(number v) {
        this->ip_58_value = v;
        this->ip_58_fillSigBuf();
        this->ip_58_lastValue = v;
    }
    
    void eventinlet_63_out1_number_set(number v) {
        this->ip_58_value_set(v);
    }
    
    void ip_59_value_set(number v) {
        this->ip_59_value = v;
        this->ip_59_fillSigBuf();
        this->ip_59_lastValue = v;
    }
    
    void eventinlet_64_out1_number_set(number v) {
        this->ip_59_value_set(v);
    }
    
    void ip_55_value_set(number v) {
        this->ip_55_value = v;
        this->ip_55_fillSigBuf();
        this->ip_55_lastValue = v;
    }
    
    void eventinlet_60_out1_number_set(number v) {
        this->ip_55_value_set(v);
    }
    
    void ip_56_value_set(number v) {
        this->ip_56_value = v;
        this->ip_56_fillSigBuf();
        this->ip_56_lastValue = v;
    }
    
    void eventinlet_61_out1_number_set(number v) {
        this->ip_56_value_set(v);
    }
    
    void ip_60_value_set(number v) {
        this->ip_60_value = v;
        this->ip_60_fillSigBuf();
        this->ip_60_lastValue = v;
    }
    
    void eventinlet_65_out1_number_set(number v) {
        this->ip_60_value_set(v);
    }
    
    void click_05_click_number_set(number v) {
        for (SampleIndex i = (SampleIndex)(this->click_05_lastclick + 1); i < this->sampleOffsetIntoNextAudioBuffer; i++) {
            this->click_05_buf[(Index)i] = 0;
        }
    
        this->click_05_lastclick = this->sampleOffsetIntoNextAudioBuffer;
        this->click_05_buf[(Index)this->click_05_lastclick] = v;
    }
    
    void click_05_click_bang_bang() {
        this->click_05_click_number_set(1);
    }
    
    void eventinlet_53_out1_bang_bang() {
        this->click_05_click_bang_bang();
    }
    
    void eventinlet_53_out1_number_set(number v) {
        this->click_05_click_number_set(v);
    }
    
    template<typename LISTTYPE> void eventinlet_53_out1_list_set(const LISTTYPE& v) {
        {
            number converted = (v->length > 0 ? v[0] : 0);
            this->click_05_click_number_set(converted);
        }
    }
    
    void ip_49_value_bang() {
        number v = this->ip_49_value;
        this->ip_49_fillSigBuf();
        this->ip_49_lastValue = v;
    }
    
    void ip_49_impulse_set(number v) {
        this->ip_49_impulse = v;
        this->ip_49_fillSigBuf();
        this->ip_49_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_49_resetCount = lengthInSamples;
    }
    
    void ip_50_value_bang() {
        number v = this->ip_50_value;
        this->ip_50_fillSigBuf();
        this->ip_50_lastValue = v;
    }
    
    void ip_50_impulse_set(number v) {
        this->ip_50_impulse = v;
        this->ip_50_fillSigBuf();
        this->ip_50_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_50_resetCount = lengthInSamples;
    }
    
    void ip_51_value_bang() {
        number v = this->ip_51_value;
        this->ip_51_fillSigBuf();
        this->ip_51_lastValue = v;
    }
    
    void ip_51_impulse_set(number v) {
        this->ip_51_impulse = v;
        this->ip_51_fillSigBuf();
        this->ip_51_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_51_resetCount = lengthInSamples;
    }
    
    void ip_52_value_bang() {
        number v = this->ip_52_value;
        this->ip_52_fillSigBuf();
        this->ip_52_lastValue = v;
    }
    
    void ip_52_impulse_set(number v) {
        this->ip_52_impulse = v;
        this->ip_52_fillSigBuf();
        this->ip_52_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_52_resetCount = lengthInSamples;
    }
    
    void ip_53_value_bang() {
        number v = this->ip_53_value;
        this->ip_53_fillSigBuf();
        this->ip_53_lastValue = v;
    }
    
    void ip_53_impulse_set(number v) {
        this->ip_53_impulse = v;
        this->ip_53_fillSigBuf();
        this->ip_53_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_53_resetCount = lengthInSamples;
    }
    
    void ip_54_value_bang() {
        number v = this->ip_54_value;
        this->ip_54_fillSigBuf();
        this->ip_54_lastValue = v;
    }
    
    void ip_54_impulse_set(number v) {
        this->ip_54_impulse = v;
        this->ip_54_fillSigBuf();
        this->ip_54_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_54_resetCount = lengthInSamples;
    }
    
    void ip_55_value_bang() {
        number v = this->ip_55_value;
        this->ip_55_fillSigBuf();
        this->ip_55_lastValue = v;
    }
    
    void ip_55_impulse_set(number v) {
        this->ip_55_impulse = v;
        this->ip_55_fillSigBuf();
        this->ip_55_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_55_resetCount = lengthInSamples;
    }
    
    void ip_56_value_bang() {
        number v = this->ip_56_value;
        this->ip_56_fillSigBuf();
        this->ip_56_lastValue = v;
    }
    
    void ip_56_impulse_set(number v) {
        this->ip_56_impulse = v;
        this->ip_56_fillSigBuf();
        this->ip_56_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_56_resetCount = lengthInSamples;
    }
    
    void ip_57_value_bang() {
        number v = this->ip_57_value;
        this->ip_57_fillSigBuf();
        this->ip_57_lastValue = v;
    }
    
    void ip_57_impulse_set(number v) {
        this->ip_57_impulse = v;
        this->ip_57_fillSigBuf();
        this->ip_57_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_57_resetCount = lengthInSamples;
    }
    
    void ip_58_value_bang() {
        number v = this->ip_58_value;
        this->ip_58_fillSigBuf();
        this->ip_58_lastValue = v;
    }
    
    void ip_58_impulse_set(number v) {
        this->ip_58_impulse = v;
        this->ip_58_fillSigBuf();
        this->ip_58_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_58_resetCount = lengthInSamples;
    }
    
    void ip_59_value_bang() {
        number v = this->ip_59_value;
        this->ip_59_fillSigBuf();
        this->ip_59_lastValue = v;
    }
    
    void ip_59_impulse_set(number v) {
        this->ip_59_impulse = v;
        this->ip_59_fillSigBuf();
        this->ip_59_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_59_resetCount = lengthInSamples;
    }
    
    void ip_60_value_bang() {
        number v = this->ip_60_value;
        this->ip_60_fillSigBuf();
        this->ip_60_lastValue = v;
    }
    
    void ip_60_impulse_set(number v) {
        this->ip_60_impulse = v;
        this->ip_60_fillSigBuf();
        this->ip_60_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_60_resetCount = lengthInSamples;
    }
    
    void click_05_perform(SampleValue * out, Index n) {
        auto __click_05_lastclick = this->click_05_lastclick;
    
        for (SampleIndex i = 0; i <= __click_05_lastclick; i++) {
            out[(Index)i] = this->click_05_buf[(Index)i];
        }
    
        for (SampleIndex i = (SampleIndex)(__click_05_lastclick + 1); i < (SampleIndex)(n); i++) {
            out[(Index)i] = 0;
        }
    
        __click_05_lastclick = -1;
        this->click_05_lastclick = __click_05_lastclick;
    }
    
    void ip_49_perform(SampleValue * out, Index n) {
        auto __ip_49_lastValue = this->ip_49_lastValue;
        auto __ip_49_lastIndex = this->ip_49_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_49_lastIndex ? __ip_49_lastValue : this->ip_49_sigbuf[(Index)i]);
        }
    
        __ip_49_lastIndex = 0;
        this->ip_49_lastIndex = __ip_49_lastIndex;
    }
    
    void ip_50_perform(SampleValue * out, Index n) {
        auto __ip_50_lastValue = this->ip_50_lastValue;
        auto __ip_50_lastIndex = this->ip_50_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_50_lastIndex ? __ip_50_lastValue : this->ip_50_sigbuf[(Index)i]);
        }
    
        __ip_50_lastIndex = 0;
        this->ip_50_lastIndex = __ip_50_lastIndex;
    }
    
    void ip_51_perform(SampleValue * out, Index n) {
        auto __ip_51_lastValue = this->ip_51_lastValue;
        auto __ip_51_lastIndex = this->ip_51_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_51_lastIndex ? __ip_51_lastValue : this->ip_51_sigbuf[(Index)i]);
        }
    
        __ip_51_lastIndex = 0;
        this->ip_51_lastIndex = __ip_51_lastIndex;
    }
    
    void ip_52_perform(SampleValue * out, Index n) {
        auto __ip_52_lastValue = this->ip_52_lastValue;
        auto __ip_52_lastIndex = this->ip_52_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_52_lastIndex ? __ip_52_lastValue : this->ip_52_sigbuf[(Index)i]);
        }
    
        __ip_52_lastIndex = 0;
        this->ip_52_lastIndex = __ip_52_lastIndex;
    }
    
    void ip_53_perform(SampleValue * out, Index n) {
        auto __ip_53_lastValue = this->ip_53_lastValue;
        auto __ip_53_lastIndex = this->ip_53_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_53_lastIndex ? __ip_53_lastValue : this->ip_53_sigbuf[(Index)i]);
        }
    
        __ip_53_lastIndex = 0;
        this->ip_53_lastIndex = __ip_53_lastIndex;
    }
    
    void ip_54_perform(SampleValue * out, Index n) {
        auto __ip_54_lastValue = this->ip_54_lastValue;
        auto __ip_54_lastIndex = this->ip_54_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_54_lastIndex ? __ip_54_lastValue : this->ip_54_sigbuf[(Index)i]);
        }
    
        __ip_54_lastIndex = 0;
        this->ip_54_lastIndex = __ip_54_lastIndex;
    }
    
    void ip_55_perform(SampleValue * out, Index n) {
        auto __ip_55_lastValue = this->ip_55_lastValue;
        auto __ip_55_lastIndex = this->ip_55_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_55_lastIndex ? __ip_55_lastValue : this->ip_55_sigbuf[(Index)i]);
        }
    
        __ip_55_lastIndex = 0;
        this->ip_55_lastIndex = __ip_55_lastIndex;
    }
    
    void ip_56_perform(SampleValue * out, Index n) {
        auto __ip_56_lastValue = this->ip_56_lastValue;
        auto __ip_56_lastIndex = this->ip_56_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_56_lastIndex ? __ip_56_lastValue : this->ip_56_sigbuf[(Index)i]);
        }
    
        __ip_56_lastIndex = 0;
        this->ip_56_lastIndex = __ip_56_lastIndex;
    }
    
    void ip_57_perform(SampleValue * out, Index n) {
        auto __ip_57_lastValue = this->ip_57_lastValue;
        auto __ip_57_lastIndex = this->ip_57_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_57_lastIndex ? __ip_57_lastValue : this->ip_57_sigbuf[(Index)i]);
        }
    
        __ip_57_lastIndex = 0;
        this->ip_57_lastIndex = __ip_57_lastIndex;
    }
    
    void ip_58_perform(SampleValue * out, Index n) {
        auto __ip_58_lastValue = this->ip_58_lastValue;
        auto __ip_58_lastIndex = this->ip_58_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_58_lastIndex ? __ip_58_lastValue : this->ip_58_sigbuf[(Index)i]);
        }
    
        __ip_58_lastIndex = 0;
        this->ip_58_lastIndex = __ip_58_lastIndex;
    }
    
    void ip_59_perform(SampleValue * out, Index n) {
        auto __ip_59_lastValue = this->ip_59_lastValue;
        auto __ip_59_lastIndex = this->ip_59_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_59_lastIndex ? __ip_59_lastValue : this->ip_59_sigbuf[(Index)i]);
        }
    
        __ip_59_lastIndex = 0;
        this->ip_59_lastIndex = __ip_59_lastIndex;
    }
    
    void ip_60_perform(SampleValue * out, Index n) {
        auto __ip_60_lastValue = this->ip_60_lastValue;
        auto __ip_60_lastIndex = this->ip_60_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_60_lastIndex ? __ip_60_lastValue : this->ip_60_sigbuf[(Index)i]);
        }
    
        __ip_60_lastIndex = 0;
        this->ip_60_lastIndex = __ip_60_lastIndex;
    }
    
    void codebox_tilde_05_perform(
        const Sample * in1,
        const Sample * in2,
        const Sample * in3,
        const Sample * in4,
        const Sample * in5,
        const Sample * in6,
        const Sample * in7,
        const Sample * in8,
        const Sample * in9,
        const Sample * in10,
        const Sample * in11,
        const Sample * in12,
        const Sample * in13,
        SampleValue * out1,
        Index n
    ) {
        auto __codebox_tilde_05_noiseState = this->codebox_tilde_05_noiseState;
        auto __codebox_tilde_05_noiseCoef = this->codebox_tilde_05_noiseCoef;
        auto __codebox_tilde_05_bendCoef = this->codebox_tilde_05_bendCoef;
        auto __codebox_tilde_05_envCoef = this->codebox_tilde_05_envCoef;
        auto __codebox_tilde_05_modPhase = this->codebox_tilde_05_modPhase;
        auto __codebox_tilde_05_modePhase = this->codebox_tilde_05_modePhase;
        auto __codebox_tilde_05_phase = this->codebox_tilde_05_phase;
        auto __codebox_tilde_05_noiseEnv = this->codebox_tilde_05_noiseEnv;
        auto __codebox_tilde_05_bendEnv = this->codebox_tilde_05_bendEnv;
        auto __codebox_tilde_05_env = this->codebox_tilde_05_env;
        auto __codebox_tilde_05_active = this->codebox_tilde_05_active;
        auto __codebox_tilde_05_hitLevel = this->codebox_tilde_05_hitLevel;
        auto __codebox_tilde_05_hitDrive = this->codebox_tilde_05_hitDrive;
        auto __codebox_tilde_05_hitNoiseDecayMs = this->codebox_tilde_05_hitNoiseDecayMs;
        auto __codebox_tilde_05_hitNoiseLevel = this->codebox_tilde_05_hitNoiseLevel;
        auto __codebox_tilde_05_hitModeLevel = this->codebox_tilde_05_hitModeLevel;
        auto __codebox_tilde_05_hitModeRatio = this->codebox_tilde_05_hitModeRatio;
        auto __codebox_tilde_05_hitFmRatio = this->codebox_tilde_05_hitFmRatio;
        auto __codebox_tilde_05_hitFmAmount = this->codebox_tilde_05_hitFmAmount;
        auto __codebox_tilde_05_hitBendDecayMs = this->codebox_tilde_05_hitBendDecayMs;
        auto __codebox_tilde_05_hitBendHz = this->codebox_tilde_05_hitBendHz;
        auto __codebox_tilde_05_hitDecayMs = this->codebox_tilde_05_hitDecayMs;
        auto __codebox_tilde_05_hitPitchHz = this->codebox_tilde_05_hitPitchHz;
        Index i;
    
        for (i = 0; i < (Index)n; i++) {
            number trig = in1[(Index)i];
            number sr = this->sr;
    
            if (trig > 0) {
                __codebox_tilde_05_hitPitchHz = in2[(Index)i];//#map:_###_obj_###_:28
                __codebox_tilde_05_hitDecayMs = in3[(Index)i];//#map:_###_obj_###_:29
                __codebox_tilde_05_hitBendHz = in4[(Index)i];//#map:_###_obj_###_:30
                __codebox_tilde_05_hitBendDecayMs = in5[(Index)i];//#map:_###_obj_###_:31
                __codebox_tilde_05_hitFmAmount = in6[(Index)i];//#map:_###_obj_###_:32
                __codebox_tilde_05_hitFmRatio = in7[(Index)i];//#map:_###_obj_###_:33
                __codebox_tilde_05_hitModeRatio = in8[(Index)i];//#map:_###_obj_###_:34
                __codebox_tilde_05_hitModeLevel = in9[(Index)i];//#map:_###_obj_###_:35
                __codebox_tilde_05_hitNoiseLevel = in10[(Index)i];//#map:_###_obj_###_:36
                __codebox_tilde_05_hitNoiseDecayMs = in11[(Index)i];//#map:_###_obj_###_:37
                __codebox_tilde_05_hitDrive = in12[(Index)i];//#map:_###_obj_###_:38
                __codebox_tilde_05_hitLevel = in13[(Index)i];//#map:_###_obj_###_:39
            }//#map:_###_obj_###_:27
    
            if (trig > 0) {
                __codebox_tilde_05_active = 1;//#map:_###_obj_###_:42
                __codebox_tilde_05_env = 1;//#map:_###_obj_###_:43
                __codebox_tilde_05_bendEnv = 1;//#map:_###_obj_###_:43
                __codebox_tilde_05_noiseEnv = 1;//#map:_###_obj_###_:43
                __codebox_tilde_05_phase = 0;//#map:_###_obj_###_:44
                __codebox_tilde_05_modePhase = 0;//#map:_###_obj_###_:44
                __codebox_tilde_05_modPhase = 0;//#map:_###_obj_###_:44
    
                __codebox_tilde_05_envCoef = rnbo_exp(
                    (this->maximum(10, __codebox_tilde_05_hitDecayMs) * 0.001 * sr == 0. ? 0. : -6.907755 / (this->maximum(10, __codebox_tilde_05_hitDecayMs) * 0.001 * sr))
                );//#map:_###_obj_###_:45
    
                __codebox_tilde_05_bendCoef = rnbo_exp(
                    (this->maximum(1, __codebox_tilde_05_hitBendDecayMs) * 0.001 * sr == 0. ? 0. : -6.907755 / (this->maximum(1, __codebox_tilde_05_hitBendDecayMs) * 0.001 * sr))
                );//#map:_###_obj_###_:46
    
                __codebox_tilde_05_noiseCoef = rnbo_exp(
                    (this->maximum(1, __codebox_tilde_05_hitNoiseDecayMs) * 0.001 * sr == 0. ? 0. : -6.907755 / (this->maximum(1, __codebox_tilde_05_hitNoiseDecayMs) * 0.001 * sr))
                );//#map:_###_obj_###_:47
            }//#map:_###_obj_###_:41
    
            out1[(Index)i] = 0;//#map:_###_obj_###_:49
    
            if (__codebox_tilde_05_active > 0) {
                __codebox_tilde_05_env *= __codebox_tilde_05_envCoef;//#map:_###_obj_###_:51
                __codebox_tilde_05_bendEnv *= __codebox_tilde_05_bendCoef;//#map:_###_obj_###_:51
                __codebox_tilde_05_noiseEnv *= __codebox_tilde_05_noiseCoef;//#map:_###_obj_###_:51
                number hz = (__codebox_tilde_05_hitPitchHz + __codebox_tilde_05_hitBendHz * __codebox_tilde_05_bendEnv > sr * 0.2 ? sr * 0.2 : (__codebox_tilde_05_hitPitchHz + __codebox_tilde_05_hitBendHz * __codebox_tilde_05_bendEnv < 20 ? 20 : __codebox_tilde_05_hitPitchHz + __codebox_tilde_05_hitBendHz * __codebox_tilde_05_bendEnv));
    
                __codebox_tilde_05_modPhase = this->wrap(
                    __codebox_tilde_05_modPhase + ((sr == 0. ? 0. : this->minimum(hz * __codebox_tilde_05_hitFmRatio, sr * 0.45) / sr)),
                    0,
                    1
                );//#map:_###_obj_###_:53
    
                __codebox_tilde_05_phase = this->wrap(__codebox_tilde_05_phase + ((sr == 0. ? 0. : hz / sr)), 0, 1);//#map:_###_obj_###_:54
    
                __codebox_tilde_05_modePhase = this->wrap(
                    __codebox_tilde_05_modePhase + ((sr == 0. ? 0. : this->minimum(hz * __codebox_tilde_05_hitModeRatio, sr * 0.45) / sr)),
                    0,
                    1
                );//#map:_###_obj_###_:55
    
                number membrane = rnbo_sin(
                    __codebox_tilde_05_phase * 6.283185307179586 + rnbo_sin(__codebox_tilde_05_modPhase * 6.283185307179586) * __codebox_tilde_05_hitFmAmount * __codebox_tilde_05_env
                );
    
                number shell = rnbo_sin(__codebox_tilde_05_modePhase * 6.283185307179586) * __codebox_tilde_05_env * __codebox_tilde_05_env;
                __codebox_tilde_05_noiseState = this->wrap((__codebox_tilde_05_noiseState + 1) * 16807, 0, 2147483647) - 1;//#map:_###_obj_###_:58
                number white = (__codebox_tilde_05_noiseState + 1) / (number)1073741823.5 - 1;
                number raw = membrane * __codebox_tilde_05_env * 0.8 + shell * __codebox_tilde_05_hitModeLevel * 0.6 + white * __codebox_tilde_05_noiseEnv * __codebox_tilde_05_hitNoiseLevel * 0.4;
                auto drive = this->maximum(0.25, __codebox_tilde_05_hitDrive);
                out1[(Index)i] = ((rnbo_tanh(drive) == 0. ? 0. : rnbo_tanh(raw * drive) / rnbo_tanh(drive))) * ((__codebox_tilde_05_hitLevel > 1 ? 1 : (__codebox_tilde_05_hitLevel < 0 ? 0 : __codebox_tilde_05_hitLevel)));//#map:_###_obj_###_:62
    
                if (__codebox_tilde_05_env < 1e-7 && __codebox_tilde_05_noiseEnv < 1e-7)
                    __codebox_tilde_05_active = 0;//#map:_###_obj_###_:63;//#map:_###_obj_###_:63
            }//#map:_###_obj_###_:50
        }
    
        this->codebox_tilde_05_hitPitchHz = __codebox_tilde_05_hitPitchHz;
        this->codebox_tilde_05_hitDecayMs = __codebox_tilde_05_hitDecayMs;
        this->codebox_tilde_05_hitBendHz = __codebox_tilde_05_hitBendHz;
        this->codebox_tilde_05_hitBendDecayMs = __codebox_tilde_05_hitBendDecayMs;
        this->codebox_tilde_05_hitFmAmount = __codebox_tilde_05_hitFmAmount;
        this->codebox_tilde_05_hitFmRatio = __codebox_tilde_05_hitFmRatio;
        this->codebox_tilde_05_hitModeRatio = __codebox_tilde_05_hitModeRatio;
        this->codebox_tilde_05_hitModeLevel = __codebox_tilde_05_hitModeLevel;
        this->codebox_tilde_05_hitNoiseLevel = __codebox_tilde_05_hitNoiseLevel;
        this->codebox_tilde_05_hitNoiseDecayMs = __codebox_tilde_05_hitNoiseDecayMs;
        this->codebox_tilde_05_hitDrive = __codebox_tilde_05_hitDrive;
        this->codebox_tilde_05_hitLevel = __codebox_tilde_05_hitLevel;
        this->codebox_tilde_05_active = __codebox_tilde_05_active;
        this->codebox_tilde_05_env = __codebox_tilde_05_env;
        this->codebox_tilde_05_bendEnv = __codebox_tilde_05_bendEnv;
        this->codebox_tilde_05_noiseEnv = __codebox_tilde_05_noiseEnv;
        this->codebox_tilde_05_phase = __codebox_tilde_05_phase;
        this->codebox_tilde_05_modePhase = __codebox_tilde_05_modePhase;
        this->codebox_tilde_05_modPhase = __codebox_tilde_05_modPhase;
        this->codebox_tilde_05_envCoef = __codebox_tilde_05_envCoef;
        this->codebox_tilde_05_bendCoef = __codebox_tilde_05_bendCoef;
        this->codebox_tilde_05_noiseCoef = __codebox_tilde_05_noiseCoef;
        this->codebox_tilde_05_noiseState = __codebox_tilde_05_noiseState;
    }
    
    void dspexpr_05_perform(const Sample * in1, number in2, SampleValue * out1, Index n) {
        RNBO_UNUSED(in2);
        Index i;
    
        for (i = 0; i < (Index)n; i++) {
            out1[(Index)i] = in1[(Index)i] * 1;//#map:_###_obj_###_:1
        }
    }
    
    void signalforwarder_09_perform(const SampleValue * input, SampleValue * output, Index n) {
        copySignal(output, input, n);
    }
    
    void signalforwarder_10_perform(const SampleValue * input, SampleValue * output, Index n) {
        copySignal(output, input, n);
    }
    
    void stackprotect_perform(Index n) {
        RNBO_UNUSED(n);
        auto __stackprotect_count = this->stackprotect_count;
        __stackprotect_count = 0;
        this->stackprotect_count = __stackprotect_count;
    }
    
    void ip_49_init() {
        this->ip_49_lastValue = this->ip_49_value;
    }
    
    void ip_49_fillSigBuf() {
        if ((bool)(this->ip_49_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_49_lastIndex); i < k; i++) {
                if (this->ip_49_resetCount > 0) {
                    this->ip_49_sigbuf[(Index)i] = 1;
                    this->ip_49_resetCount--;
                } else {
                    this->ip_49_sigbuf[(Index)i] = this->ip_49_lastValue;
                }
            }
    
            this->ip_49_lastIndex = k;
        }
    }
    
    void ip_49_dspsetup(bool force) {
        if ((bool)(this->ip_49_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_49_lastIndex = 0;
        this->ip_49_setupDone = true;
    }
    
    void ip_50_init() {
        this->ip_50_lastValue = this->ip_50_value;
    }
    
    void ip_50_fillSigBuf() {
        if ((bool)(this->ip_50_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_50_lastIndex); i < k; i++) {
                if (this->ip_50_resetCount > 0) {
                    this->ip_50_sigbuf[(Index)i] = 1;
                    this->ip_50_resetCount--;
                } else {
                    this->ip_50_sigbuf[(Index)i] = this->ip_50_lastValue;
                }
            }
    
            this->ip_50_lastIndex = k;
        }
    }
    
    void ip_50_dspsetup(bool force) {
        if ((bool)(this->ip_50_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_50_lastIndex = 0;
        this->ip_50_setupDone = true;
    }
    
    void ip_51_init() {
        this->ip_51_lastValue = this->ip_51_value;
    }
    
    void ip_51_fillSigBuf() {
        if ((bool)(this->ip_51_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_51_lastIndex); i < k; i++) {
                if (this->ip_51_resetCount > 0) {
                    this->ip_51_sigbuf[(Index)i] = 1;
                    this->ip_51_resetCount--;
                } else {
                    this->ip_51_sigbuf[(Index)i] = this->ip_51_lastValue;
                }
            }
    
            this->ip_51_lastIndex = k;
        }
    }
    
    void ip_51_dspsetup(bool force) {
        if ((bool)(this->ip_51_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_51_lastIndex = 0;
        this->ip_51_setupDone = true;
    }
    
    void ip_52_init() {
        this->ip_52_lastValue = this->ip_52_value;
    }
    
    void ip_52_fillSigBuf() {
        if ((bool)(this->ip_52_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_52_lastIndex); i < k; i++) {
                if (this->ip_52_resetCount > 0) {
                    this->ip_52_sigbuf[(Index)i] = 1;
                    this->ip_52_resetCount--;
                } else {
                    this->ip_52_sigbuf[(Index)i] = this->ip_52_lastValue;
                }
            }
    
            this->ip_52_lastIndex = k;
        }
    }
    
    void ip_52_dspsetup(bool force) {
        if ((bool)(this->ip_52_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_52_lastIndex = 0;
        this->ip_52_setupDone = true;
    }
    
    void ip_53_init() {
        this->ip_53_lastValue = this->ip_53_value;
    }
    
    void ip_53_fillSigBuf() {
        if ((bool)(this->ip_53_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_53_lastIndex); i < k; i++) {
                if (this->ip_53_resetCount > 0) {
                    this->ip_53_sigbuf[(Index)i] = 1;
                    this->ip_53_resetCount--;
                } else {
                    this->ip_53_sigbuf[(Index)i] = this->ip_53_lastValue;
                }
            }
    
            this->ip_53_lastIndex = k;
        }
    }
    
    void ip_53_dspsetup(bool force) {
        if ((bool)(this->ip_53_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_53_lastIndex = 0;
        this->ip_53_setupDone = true;
    }
    
    void ip_54_init() {
        this->ip_54_lastValue = this->ip_54_value;
    }
    
    void ip_54_fillSigBuf() {
        if ((bool)(this->ip_54_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_54_lastIndex); i < k; i++) {
                if (this->ip_54_resetCount > 0) {
                    this->ip_54_sigbuf[(Index)i] = 1;
                    this->ip_54_resetCount--;
                } else {
                    this->ip_54_sigbuf[(Index)i] = this->ip_54_lastValue;
                }
            }
    
            this->ip_54_lastIndex = k;
        }
    }
    
    void ip_54_dspsetup(bool force) {
        if ((bool)(this->ip_54_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_54_lastIndex = 0;
        this->ip_54_setupDone = true;
    }
    
    void ip_55_init() {
        this->ip_55_lastValue = this->ip_55_value;
    }
    
    void ip_55_fillSigBuf() {
        if ((bool)(this->ip_55_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_55_lastIndex); i < k; i++) {
                if (this->ip_55_resetCount > 0) {
                    this->ip_55_sigbuf[(Index)i] = 1;
                    this->ip_55_resetCount--;
                } else {
                    this->ip_55_sigbuf[(Index)i] = this->ip_55_lastValue;
                }
            }
    
            this->ip_55_lastIndex = k;
        }
    }
    
    void ip_55_dspsetup(bool force) {
        if ((bool)(this->ip_55_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_55_lastIndex = 0;
        this->ip_55_setupDone = true;
    }
    
    void ip_56_init() {
        this->ip_56_lastValue = this->ip_56_value;
    }
    
    void ip_56_fillSigBuf() {
        if ((bool)(this->ip_56_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_56_lastIndex); i < k; i++) {
                if (this->ip_56_resetCount > 0) {
                    this->ip_56_sigbuf[(Index)i] = 1;
                    this->ip_56_resetCount--;
                } else {
                    this->ip_56_sigbuf[(Index)i] = this->ip_56_lastValue;
                }
            }
    
            this->ip_56_lastIndex = k;
        }
    }
    
    void ip_56_dspsetup(bool force) {
        if ((bool)(this->ip_56_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_56_lastIndex = 0;
        this->ip_56_setupDone = true;
    }
    
    void ip_57_init() {
        this->ip_57_lastValue = this->ip_57_value;
    }
    
    void ip_57_fillSigBuf() {
        if ((bool)(this->ip_57_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_57_lastIndex); i < k; i++) {
                if (this->ip_57_resetCount > 0) {
                    this->ip_57_sigbuf[(Index)i] = 1;
                    this->ip_57_resetCount--;
                } else {
                    this->ip_57_sigbuf[(Index)i] = this->ip_57_lastValue;
                }
            }
    
            this->ip_57_lastIndex = k;
        }
    }
    
    void ip_57_dspsetup(bool force) {
        if ((bool)(this->ip_57_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_57_lastIndex = 0;
        this->ip_57_setupDone = true;
    }
    
    void ip_58_init() {
        this->ip_58_lastValue = this->ip_58_value;
    }
    
    void ip_58_fillSigBuf() {
        if ((bool)(this->ip_58_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_58_lastIndex); i < k; i++) {
                if (this->ip_58_resetCount > 0) {
                    this->ip_58_sigbuf[(Index)i] = 1;
                    this->ip_58_resetCount--;
                } else {
                    this->ip_58_sigbuf[(Index)i] = this->ip_58_lastValue;
                }
            }
    
            this->ip_58_lastIndex = k;
        }
    }
    
    void ip_58_dspsetup(bool force) {
        if ((bool)(this->ip_58_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_58_lastIndex = 0;
        this->ip_58_setupDone = true;
    }
    
    void ip_59_init() {
        this->ip_59_lastValue = this->ip_59_value;
    }
    
    void ip_59_fillSigBuf() {
        if ((bool)(this->ip_59_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_59_lastIndex); i < k; i++) {
                if (this->ip_59_resetCount > 0) {
                    this->ip_59_sigbuf[(Index)i] = 1;
                    this->ip_59_resetCount--;
                } else {
                    this->ip_59_sigbuf[(Index)i] = this->ip_59_lastValue;
                }
            }
    
            this->ip_59_lastIndex = k;
        }
    }
    
    void ip_59_dspsetup(bool force) {
        if ((bool)(this->ip_59_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_59_lastIndex = 0;
        this->ip_59_setupDone = true;
    }
    
    void ip_60_init() {
        this->ip_60_lastValue = this->ip_60_value;
    }
    
    void ip_60_fillSigBuf() {
        if ((bool)(this->ip_60_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_60_lastIndex); i < k; i++) {
                if (this->ip_60_resetCount > 0) {
                    this->ip_60_sigbuf[(Index)i] = 1;
                    this->ip_60_resetCount--;
                } else {
                    this->ip_60_sigbuf[(Index)i] = this->ip_60_lastValue;
                }
            }
    
            this->ip_60_lastIndex = k;
        }
    }
    
    void ip_60_dspsetup(bool force) {
        if ((bool)(this->ip_60_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_60_lastIndex = 0;
        this->ip_60_setupDone = true;
    }
    
    bool stackprotect_check() {
        this->stackprotect_count++;
    
        if (this->stackprotect_count > 128) {
            console->log("STACK OVERFLOW DETECTED - stopped processing branch !");
            return true;
        }
    
        return false;
    }
    
    Index getPatcherSerial() const {
        return 0;
    }
    
    void sendParameter(ParameterIndex index, bool ignoreValue) {
        this->getPatcher()->sendParameter(index + this->parameterOffset, ignoreValue);
    }
    
    void scheduleParamInit(ParameterIndex index, Index order) {
        this->getPatcher()->scheduleParamInit(index + this->parameterOffset, order);
    }
    
    void updateTime(MillisecondTime time, EXTERNALENGINE* engine, bool inProcess = false) {
        RNBO_UNUSED(inProcess);
        RNBO_UNUSED(engine);
        this->_currentTime = time;
        auto offset = rnbo_fround(this->msToSamps(time - this->getEngine()->getCurrentTime(), this->sr));
    
        if (offset >= (SampleIndex)(this->vs))
            offset = (SampleIndex)(this->vs) - 1;
    
        if (offset < 0)
            offset = 0;
    
        this->sampleOffsetIntoNextAudioBuffer = (Index)(offset);
    }
    
    void assign_defaults()
    {
        ip_49_value = 0;
        ip_49_impulse = 0;
        ip_50_value = 0;
        ip_50_impulse = 0;
        ip_51_value = 0;
        ip_51_impulse = 0;
        ip_52_value = 0;
        ip_52_impulse = 0;
        ip_53_value = 0;
        ip_53_impulse = 0;
        ip_54_value = 0;
        ip_54_impulse = 0;
        ip_55_value = 0;
        ip_55_impulse = 0;
        ip_56_value = 0;
        ip_56_impulse = 0;
        ip_57_value = 0;
        ip_57_impulse = 0;
        ip_58_value = 0;
        ip_58_impulse = 0;
        ip_59_value = 0;
        ip_59_impulse = 0;
        ip_60_value = 0;
        ip_60_impulse = 0;
        codebox_tilde_05_in1 = 0;
        codebox_tilde_05_in2 = 0;
        codebox_tilde_05_in3 = 0;
        codebox_tilde_05_in4 = 0;
        codebox_tilde_05_in5 = 0;
        codebox_tilde_05_in6 = 0;
        codebox_tilde_05_in7 = 0;
        codebox_tilde_05_in8 = 0;
        codebox_tilde_05_in9 = 0;
        codebox_tilde_05_in10 = 0;
        codebox_tilde_05_in11 = 0;
        codebox_tilde_05_in12 = 0;
        codebox_tilde_05_in13 = 0;
        dspexpr_05_in1 = 0;
        dspexpr_05_in2 = 1;
        _currentTime = 0;
        audioProcessSampleCount = 0;
        sampleOffsetIntoNextAudioBuffer = 0;
        zeroBuffer = nullptr;
        dummyBuffer = nullptr;
        signals[0] = nullptr;
        signals[1] = nullptr;
        signals[2] = nullptr;
        signals[3] = nullptr;
        signals[4] = nullptr;
        signals[5] = nullptr;
        signals[6] = nullptr;
        signals[7] = nullptr;
        signals[8] = nullptr;
        signals[9] = nullptr;
        signals[10] = nullptr;
        signals[11] = nullptr;
        signals[12] = nullptr;
        signals[13] = nullptr;
        didAllocateSignals = 0;
        vs = 0;
        maxvs = 0;
        sr = 44100;
        invsr = 0.000022675736961451248;
        click_05_lastclick = -1;
        click_05_buf = nullptr;
        ip_49_lastIndex = 0;
        ip_49_lastValue = 0;
        ip_49_resetCount = 0;
        ip_49_sigbuf = nullptr;
        ip_49_setupDone = false;
        ip_50_lastIndex = 0;
        ip_50_lastValue = 0;
        ip_50_resetCount = 0;
        ip_50_sigbuf = nullptr;
        ip_50_setupDone = false;
        ip_51_lastIndex = 0;
        ip_51_lastValue = 0;
        ip_51_resetCount = 0;
        ip_51_sigbuf = nullptr;
        ip_51_setupDone = false;
        ip_52_lastIndex = 0;
        ip_52_lastValue = 0;
        ip_52_resetCount = 0;
        ip_52_sigbuf = nullptr;
        ip_52_setupDone = false;
        ip_53_lastIndex = 0;
        ip_53_lastValue = 0;
        ip_53_resetCount = 0;
        ip_53_sigbuf = nullptr;
        ip_53_setupDone = false;
        ip_54_lastIndex = 0;
        ip_54_lastValue = 0;
        ip_54_resetCount = 0;
        ip_54_sigbuf = nullptr;
        ip_54_setupDone = false;
        ip_55_lastIndex = 0;
        ip_55_lastValue = 0;
        ip_55_resetCount = 0;
        ip_55_sigbuf = nullptr;
        ip_55_setupDone = false;
        ip_56_lastIndex = 0;
        ip_56_lastValue = 0;
        ip_56_resetCount = 0;
        ip_56_sigbuf = nullptr;
        ip_56_setupDone = false;
        ip_57_lastIndex = 0;
        ip_57_lastValue = 0;
        ip_57_resetCount = 0;
        ip_57_sigbuf = nullptr;
        ip_57_setupDone = false;
        ip_58_lastIndex = 0;
        ip_58_lastValue = 0;
        ip_58_resetCount = 0;
        ip_58_sigbuf = nullptr;
        ip_58_setupDone = false;
        ip_59_lastIndex = 0;
        ip_59_lastValue = 0;
        ip_59_resetCount = 0;
        ip_59_sigbuf = nullptr;
        ip_59_setupDone = false;
        ip_60_lastIndex = 0;
        ip_60_lastValue = 0;
        ip_60_resetCount = 0;
        ip_60_sigbuf = nullptr;
        ip_60_setupDone = false;
        codebox_tilde_05_hitPitchHz = 140;
        codebox_tilde_05_hitDecayMs = 450;
        codebox_tilde_05_hitBendHz = 160;
        codebox_tilde_05_hitBendDecayMs = 35;
        codebox_tilde_05_hitFmAmount = 0.5;
        codebox_tilde_05_hitFmRatio = 1.5;
        codebox_tilde_05_hitModeRatio = 1.59;
        codebox_tilde_05_hitModeLevel = 0.25;
        codebox_tilde_05_hitNoiseLevel = 0.08;
        codebox_tilde_05_hitNoiseDecayMs = 12;
        codebox_tilde_05_hitDrive = 1.3;
        codebox_tilde_05_hitLevel = 0.5;
        codebox_tilde_05_active = 0;
        codebox_tilde_05_env = 0;
        codebox_tilde_05_bendEnv = 0;
        codebox_tilde_05_noiseEnv = 0;
        codebox_tilde_05_envCoef = 0;
        codebox_tilde_05_bendCoef = 0;
        codebox_tilde_05_noiseCoef = 0;
        codebox_tilde_05_phase = 0;
        codebox_tilde_05_modePhase = 0;
        codebox_tilde_05_modPhase = 0;
        codebox_tilde_05_noiseState = 12344;
        stackprotect_count = 0;
        _voiceIndex = 0;
        _noteNumber = 0;
        isMuted = 1;
        parameterOffset = 0;
    }
    
    // member variables
    
        number ip_49_value;
        number ip_49_impulse;
        number ip_50_value;
        number ip_50_impulse;
        number ip_51_value;
        number ip_51_impulse;
        number ip_52_value;
        number ip_52_impulse;
        number ip_53_value;
        number ip_53_impulse;
        number ip_54_value;
        number ip_54_impulse;
        number ip_55_value;
        number ip_55_impulse;
        number ip_56_value;
        number ip_56_impulse;
        number ip_57_value;
        number ip_57_impulse;
        number ip_58_value;
        number ip_58_impulse;
        number ip_59_value;
        number ip_59_impulse;
        number ip_60_value;
        number ip_60_impulse;
        number codebox_tilde_05_in1;
        number codebox_tilde_05_in2;
        number codebox_tilde_05_in3;
        number codebox_tilde_05_in4;
        number codebox_tilde_05_in5;
        number codebox_tilde_05_in6;
        number codebox_tilde_05_in7;
        number codebox_tilde_05_in8;
        number codebox_tilde_05_in9;
        number codebox_tilde_05_in10;
        number codebox_tilde_05_in11;
        number codebox_tilde_05_in12;
        number codebox_tilde_05_in13;
        number dspexpr_05_in1;
        number dspexpr_05_in2;
        MillisecondTime _currentTime;
        UInt64 audioProcessSampleCount;
        Index sampleOffsetIntoNextAudioBuffer;
        signal zeroBuffer;
        signal dummyBuffer;
        SampleValue * signals[14];
        bool didAllocateSignals;
        Index vs;
        Index maxvs;
        number sr;
        number invsr;
        SampleIndex click_05_lastclick;
        signal click_05_buf;
        SampleIndex ip_49_lastIndex;
        number ip_49_lastValue;
        SampleIndex ip_49_resetCount;
        signal ip_49_sigbuf;
        bool ip_49_setupDone;
        SampleIndex ip_50_lastIndex;
        number ip_50_lastValue;
        SampleIndex ip_50_resetCount;
        signal ip_50_sigbuf;
        bool ip_50_setupDone;
        SampleIndex ip_51_lastIndex;
        number ip_51_lastValue;
        SampleIndex ip_51_resetCount;
        signal ip_51_sigbuf;
        bool ip_51_setupDone;
        SampleIndex ip_52_lastIndex;
        number ip_52_lastValue;
        SampleIndex ip_52_resetCount;
        signal ip_52_sigbuf;
        bool ip_52_setupDone;
        SampleIndex ip_53_lastIndex;
        number ip_53_lastValue;
        SampleIndex ip_53_resetCount;
        signal ip_53_sigbuf;
        bool ip_53_setupDone;
        SampleIndex ip_54_lastIndex;
        number ip_54_lastValue;
        SampleIndex ip_54_resetCount;
        signal ip_54_sigbuf;
        bool ip_54_setupDone;
        SampleIndex ip_55_lastIndex;
        number ip_55_lastValue;
        SampleIndex ip_55_resetCount;
        signal ip_55_sigbuf;
        bool ip_55_setupDone;
        SampleIndex ip_56_lastIndex;
        number ip_56_lastValue;
        SampleIndex ip_56_resetCount;
        signal ip_56_sigbuf;
        bool ip_56_setupDone;
        SampleIndex ip_57_lastIndex;
        number ip_57_lastValue;
        SampleIndex ip_57_resetCount;
        signal ip_57_sigbuf;
        bool ip_57_setupDone;
        SampleIndex ip_58_lastIndex;
        number ip_58_lastValue;
        SampleIndex ip_58_resetCount;
        signal ip_58_sigbuf;
        bool ip_58_setupDone;
        SampleIndex ip_59_lastIndex;
        number ip_59_lastValue;
        SampleIndex ip_59_resetCount;
        signal ip_59_sigbuf;
        bool ip_59_setupDone;
        SampleIndex ip_60_lastIndex;
        number ip_60_lastValue;
        SampleIndex ip_60_resetCount;
        signal ip_60_sigbuf;
        bool ip_60_setupDone;
        number codebox_tilde_05_hitPitchHz;
        number codebox_tilde_05_hitDecayMs;
        number codebox_tilde_05_hitBendHz;
        number codebox_tilde_05_hitBendDecayMs;
        number codebox_tilde_05_hitFmAmount;
        number codebox_tilde_05_hitFmRatio;
        number codebox_tilde_05_hitModeRatio;
        number codebox_tilde_05_hitModeLevel;
        number codebox_tilde_05_hitNoiseLevel;
        number codebox_tilde_05_hitNoiseDecayMs;
        number codebox_tilde_05_hitDrive;
        number codebox_tilde_05_hitLevel;
        number codebox_tilde_05_active;
        number codebox_tilde_05_env;
        number codebox_tilde_05_bendEnv;
        number codebox_tilde_05_noiseEnv;
        number codebox_tilde_05_envCoef;
        number codebox_tilde_05_bendCoef;
        number codebox_tilde_05_noiseCoef;
        number codebox_tilde_05_phase;
        number codebox_tilde_05_modePhase;
        number codebox_tilde_05_modPhase;
        number codebox_tilde_05_noiseState;
        number stackprotect_count;
        Index _voiceIndex;
        Int _noteNumber;
        Index isMuted;
        ParameterIndex parameterOffset;
        bool _isInitialized = false;
};

class RNBOSubpatcher_123 : public PatcherInterfaceImpl {
    
    friend class rnbomatic;
    
    public:
    
    RNBOSubpatcher_123()
    {}
    
    ~RNBOSubpatcher_123()
    {
        deallocateSignals();
    }
    
    Index getNumMidiInputPorts() const {
        return 0;
    }
    
    void processMidiEvent(MillisecondTime , int , ConstByteArray , Index ) {}
    
    Index getNumMidiOutputPorts() const {
        return 0;
    }
    
    void process(
        const SampleValue * const* inputs,
        Index numInputs,
        SampleValue * const* outputs,
        Index numOutputs,
        Index n
    ) {
        RNBO_UNUSED(numInputs);
        RNBO_UNUSED(inputs);
        this->vs = n;
        this->updateTime(this->getEngine()->getCurrentTime(), (ENGINE*)nullptr, true);
        SampleValue * out1 = (numOutputs >= 1 && outputs[0] ? outputs[0] : this->dummyBuffer);
        SampleValue * out2 = (numOutputs >= 2 && outputs[1] ? outputs[1] : this->dummyBuffer);
        this->click_06_perform(this->signals[0], n);
        this->ip_61_perform(this->signals[1], n);
        this->ip_62_perform(this->signals[2], n);
        this->ip_63_perform(this->signals[3], n);
        this->ip_64_perform(this->signals[4], n);
        this->ip_65_perform(this->signals[5], n);
        this->ip_66_perform(this->signals[6], n);
        this->ip_67_perform(this->signals[7], n);
        this->ip_68_perform(this->signals[8], n);
        this->ip_69_perform(this->signals[9], n);
        this->ip_70_perform(this->signals[10], n);
        this->ip_71_perform(this->signals[11], n);
        this->ip_72_perform(this->signals[12], n);
    
        this->codebox_tilde_06_perform(
            this->signals[0],
            this->signals[1],
            this->signals[2],
            this->signals[3],
            this->signals[4],
            this->signals[5],
            this->signals[6],
            this->signals[7],
            this->signals[8],
            this->signals[9],
            this->signals[10],
            this->signals[11],
            this->signals[12],
            this->signals[13],
            n
        );
    
        this->dspexpr_06_perform(this->signals[13], this->dspexpr_06_in2, this->signals[12], n);
        this->signalforwarder_11_perform(this->signals[12], out2, n);
        this->signalforwarder_12_perform(this->signals[12], out1, n);
        this->stackprotect_perform(n);
        this->audioProcessSampleCount += this->vs;
    }
    
    void prepareToProcess(number sampleRate, Index maxBlockSize, bool force) {
        RNBO_ASSERT(this->_isInitialized);
    
        if (this->maxvs < maxBlockSize || !this->didAllocateSignals) {
            Index i;
    
            for (i = 0; i < 14; i++) {
                this->signals[i] = resizeSignal(this->signals[i], this->maxvs, maxBlockSize);
            }
    
            this->click_06_buf = resizeSignal(this->click_06_buf, this->maxvs, maxBlockSize);
            this->ip_61_sigbuf = resizeSignal(this->ip_61_sigbuf, this->maxvs, maxBlockSize);
            this->ip_62_sigbuf = resizeSignal(this->ip_62_sigbuf, this->maxvs, maxBlockSize);
            this->ip_63_sigbuf = resizeSignal(this->ip_63_sigbuf, this->maxvs, maxBlockSize);
            this->ip_64_sigbuf = resizeSignal(this->ip_64_sigbuf, this->maxvs, maxBlockSize);
            this->ip_65_sigbuf = resizeSignal(this->ip_65_sigbuf, this->maxvs, maxBlockSize);
            this->ip_66_sigbuf = resizeSignal(this->ip_66_sigbuf, this->maxvs, maxBlockSize);
            this->ip_67_sigbuf = resizeSignal(this->ip_67_sigbuf, this->maxvs, maxBlockSize);
            this->ip_68_sigbuf = resizeSignal(this->ip_68_sigbuf, this->maxvs, maxBlockSize);
            this->ip_69_sigbuf = resizeSignal(this->ip_69_sigbuf, this->maxvs, maxBlockSize);
            this->ip_70_sigbuf = resizeSignal(this->ip_70_sigbuf, this->maxvs, maxBlockSize);
            this->ip_71_sigbuf = resizeSignal(this->ip_71_sigbuf, this->maxvs, maxBlockSize);
            this->ip_72_sigbuf = resizeSignal(this->ip_72_sigbuf, this->maxvs, maxBlockSize);
            this->zeroBuffer = resizeSignal(this->zeroBuffer, this->maxvs, maxBlockSize);
            this->dummyBuffer = resizeSignal(this->dummyBuffer, this->maxvs, maxBlockSize);
            this->didAllocateSignals = true;
        }
    
        const bool sampleRateChanged = sampleRate != this->sr;
        const bool maxvsChanged = maxBlockSize != this->maxvs;
        const bool forceDSPSetup = sampleRateChanged || maxvsChanged || force;
    
        if (sampleRateChanged || maxvsChanged) {
            this->vs = maxBlockSize;
            this->maxvs = maxBlockSize;
            this->sr = sampleRate;
            this->invsr = 1 / sampleRate;
        }
    
        this->ip_61_dspsetup(forceDSPSetup);
        this->ip_62_dspsetup(forceDSPSetup);
        this->ip_63_dspsetup(forceDSPSetup);
        this->ip_64_dspsetup(forceDSPSetup);
        this->ip_65_dspsetup(forceDSPSetup);
        this->ip_66_dspsetup(forceDSPSetup);
        this->ip_67_dspsetup(forceDSPSetup);
        this->ip_68_dspsetup(forceDSPSetup);
        this->ip_69_dspsetup(forceDSPSetup);
        this->ip_70_dspsetup(forceDSPSetup);
        this->ip_71_dspsetup(forceDSPSetup);
        this->ip_72_dspsetup(forceDSPSetup);
    
        if (sampleRateChanged)
            this->onSampleRateChanged(sampleRate);
    }
    
    number msToSamps(MillisecondTime ms, number sampleRate) {
        return ms * sampleRate * 0.001;
    }
    
    MillisecondTime sampsToMs(SampleIndex samps) {
        return samps * (this->invsr * 1000);
    }
    
    Index getNumInputChannels() const {
        return 0;
    }
    
    Index getNumOutputChannels() const {
        return 2;
    }
    
    void getPreset(PatcherStateInterface& ) {}
    
    void setPreset(MillisecondTime , PatcherStateInterface& ) {}
    
    void setParameterValue(ParameterIndex , ParameterValue , MillisecondTime ) {}
    
    void processParameterEvent(ParameterIndex index, ParameterValue value, MillisecondTime time) {
        this->setParameterValue(index, value, time);
    }
    
    void processParameterBangEvent(ParameterIndex index, MillisecondTime time) {
        this->setParameterValue(index, this->getParameterValue(index), time);
    }
    
    void processNormalizedParameterEvent(ParameterIndex index, ParameterValue value, MillisecondTime time) {
        this->setParameterValueNormalized(index, value, time);
    }
    
    ParameterValue getParameterValue(ParameterIndex index)  {
        switch (index) {
        default:
            {
            return 0;
            }
        }
    }
    
    ParameterIndex getNumSignalInParameters() const {
        return 0;
    }
    
    ParameterIndex getNumSignalOutParameters() const {
        return 0;
    }
    
    ParameterIndex getNumParameters() const {
        return 0;
    }
    
    ConstCharPointer getParameterName(ParameterIndex index) const {
        switch (index) {
        default:
            {
            return "bogus";
            }
        }
    }
    
    ConstCharPointer getParameterId(ParameterIndex index) const {
        switch (index) {
        default:
            {
            return "bogus";
            }
        }
    }
    
    void getParameterInfo(ParameterIndex , ParameterInfo * ) const {}
    
    ParameterValue applyStepsToNormalizedParameterValue(ParameterValue normalizedValue, int steps) const {
        if (steps == 1) {
            if (normalizedValue > 0) {
                normalizedValue = 1.;
            }
        } else {
            ParameterValue oneStep = (number)1. / (steps - 1);
            ParameterValue numberOfSteps = rnbo_fround(normalizedValue / oneStep * 1 / (number)1) * (number)1;
            normalizedValue = numberOfSteps * oneStep;
        }
    
        return normalizedValue;
    }
    
    ParameterValue convertToNormalizedParameterValue(ParameterIndex index, ParameterValue value) const {
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    ParameterValue convertFromNormalizedParameterValue(ParameterIndex index, ParameterValue value) const {
        value = (value < 0 ? 0 : (value > 1 ? 1 : value));
    
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    ParameterValue constrainParameterValue(ParameterIndex index, ParameterValue value) const {
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    void processNumMessage(MessageTag , MessageTag , MillisecondTime , number ) {}
    
    void processListMessage(MessageTag , MessageTag , MillisecondTime , const list& ) {}
    
    void processBangMessage(MessageTag , MessageTag , MillisecondTime ) {}
    
    MessageTagInfo resolveTag(MessageTag tag) const {
        switch (tag) {
    
        }
    
        return nullptr;
    }
    
    DataRef* getDataRef(DataRefIndex index)  {
        switch (index) {
        default:
            {
            return nullptr;
            }
        }
    }
    
    DataRefIndex getNumDataRefs() const {
        return 0;
    }
    
    void processDataViewUpdate(DataRefIndex , MillisecondTime ) {}
    
    void initialize() {
        RNBO_ASSERT(!this->_isInitialized);
        this->assign_defaults();
        this->applyState();
        this->_isInitialized = true;
    }
    
    protected:
    
    void updateTime(MillisecondTime time, INTERNALENGINE*, bool inProcess = false) {
    	if (time == TimeNow) time = getTopLevelPatcher()->getPatcherTime();
    	getTopLevelPatcher()->processInternalEvents(time);
    	updateTime(time, (EXTERNALENGINE*)nullptr);
    }
    
    RNBOSubpatcher_123* operator->() {
        return this;
    }
    const RNBOSubpatcher_123* operator->() const {
        return this;
    }
    virtual rnbomatic* getPatcher() const {
        return static_cast<rnbomatic *>(_parentPatcher);
    }
    
    rnbomatic* getTopLevelPatcher() {
        return this->getPatcher()->getTopLevelPatcher();
    }
    
    void cancelClockEvents()
    {
    }
    
    number maximum(number x, number y) {
        return (x < y ? y : x);
    }
    
    number wrap(number x, number low, number high) {
        number lo;
        number hi;
    
        if (low == high)
            return low;
    
        if (low > high) {
            hi = low;
            lo = high;
        } else {
            lo = low;
            hi = high;
        }
    
        number range = hi - lo;
    
        if (x >= lo && x < hi)
            return x;
    
        if (range <= 0.000000001)
            return lo;
    
        Int numWraps = (Int)(trunc((x - lo) / range));
        numWraps = numWraps - ((x < lo ? 1 : 0));
        number result = x - range * numWraps;
    
        if (result >= hi)
            return result - range;
        else
            return result;
    }
    
    number minimum(number x, number y) {
        return (y < x ? y : x);
    }
    
    MillisecondTime getPatcherTime() const {
        return this->_currentTime;
    }
    
    void eventinlet_67_out1_bang_bang() {
        this->ip_61_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_67_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_61_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_61_value_set(converted);
        }
    }
    
    void eventinlet_68_out1_bang_bang() {
        this->ip_62_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_68_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_62_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_62_value_set(converted);
        }
    }
    
    void eventinlet_69_out1_bang_bang() {
        this->ip_63_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_69_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_63_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_63_value_set(converted);
        }
    }
    
    void eventinlet_70_out1_bang_bang() {
        this->ip_64_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_70_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_64_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_64_value_set(converted);
        }
    }
    
    void eventinlet_71_out1_bang_bang() {
        this->ip_65_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_71_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_65_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_65_value_set(converted);
        }
    }
    
    void eventinlet_72_out1_bang_bang() {
        this->ip_66_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_72_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_66_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_66_value_set(converted);
        }
    }
    
    void eventinlet_73_out1_bang_bang() {
        this->ip_67_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_73_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_67_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_67_value_set(converted);
        }
    }
    
    void eventinlet_74_out1_bang_bang() {
        this->ip_68_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_74_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_68_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_68_value_set(converted);
        }
    }
    
    void eventinlet_75_out1_bang_bang() {
        this->ip_69_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_75_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_69_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_69_value_set(converted);
        }
    }
    
    void eventinlet_76_out1_bang_bang() {
        this->ip_70_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_76_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_70_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_70_value_set(converted);
        }
    }
    
    void eventinlet_77_out1_bang_bang() {
        this->ip_71_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_77_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_71_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_71_value_set(converted);
        }
    }
    
    void eventinlet_78_out1_bang_bang() {
        this->ip_72_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_78_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_72_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_72_value_set(converted);
        }
    }
    
    void deallocateSignals() {
        Index i;
    
        for (i = 0; i < 14; i++) {
            this->signals[i] = freeSignal(this->signals[i]);
        }
    
        this->click_06_buf = freeSignal(this->click_06_buf);
        this->ip_61_sigbuf = freeSignal(this->ip_61_sigbuf);
        this->ip_62_sigbuf = freeSignal(this->ip_62_sigbuf);
        this->ip_63_sigbuf = freeSignal(this->ip_63_sigbuf);
        this->ip_64_sigbuf = freeSignal(this->ip_64_sigbuf);
        this->ip_65_sigbuf = freeSignal(this->ip_65_sigbuf);
        this->ip_66_sigbuf = freeSignal(this->ip_66_sigbuf);
        this->ip_67_sigbuf = freeSignal(this->ip_67_sigbuf);
        this->ip_68_sigbuf = freeSignal(this->ip_68_sigbuf);
        this->ip_69_sigbuf = freeSignal(this->ip_69_sigbuf);
        this->ip_70_sigbuf = freeSignal(this->ip_70_sigbuf);
        this->ip_71_sigbuf = freeSignal(this->ip_71_sigbuf);
        this->ip_72_sigbuf = freeSignal(this->ip_72_sigbuf);
        this->zeroBuffer = freeSignal(this->zeroBuffer);
        this->dummyBuffer = freeSignal(this->dummyBuffer);
    }
    
    Index getMaxBlockSize() const {
        return this->maxvs;
    }
    
    number getSampleRate() const {
        return this->sr;
    }
    
    bool hasFixedVectorSize() const {
        return false;
    }
    
    void setProbingTarget(MessageTag ) {}
    
    void initializeObjects() {
        this->ip_61_init();
        this->ip_62_init();
        this->ip_63_init();
        this->ip_64_init();
        this->ip_65_init();
        this->ip_66_init();
        this->ip_67_init();
        this->ip_68_init();
        this->ip_69_init();
        this->ip_70_init();
        this->ip_71_init();
        this->ip_72_init();
    }
    
    Index getIsMuted()  {
        return this->isMuted;
    }
    
    void setIsMuted(Index v)  {
        this->isMuted = v;
    }
    
    void onSampleRateChanged(double ) {}
    
    void extractState(PatcherStateInterface& ) {}
    
    void applyState() {}
    
    void setParameterOffset(ParameterIndex offset) {
        this->parameterOffset = offset;
    }
    
    void processClockEvent(MillisecondTime , ClockId , bool , ParameterValue ) {}
    
    void processOutletAtCurrentTime(EngineLink* , OutletIndex , ParameterValue ) {}
    
    void processOutletEvent(
        EngineLink* sender,
        OutletIndex index,
        ParameterValue value,
        MillisecondTime time
    ) {
        this->updateTime(time, (ENGINE*)nullptr);
        this->processOutletAtCurrentTime(sender, index, value);
    }
    
    void sendOutlet(OutletIndex index, ParameterValue value) {
        this->getEngine()->sendOutlet(this, index, value);
    }
    
    void startup() {}
    
    void fillDataRef(DataRefIndex , DataRef& ) {}
    
    void allocateDataRefs() {}
    
    void ip_61_value_set(number v) {
        this->ip_61_value = v;
        this->ip_61_fillSigBuf();
        this->ip_61_lastValue = v;
    }
    
    void eventinlet_67_out1_number_set(number v) {
        this->ip_61_value_set(v);
    }
    
    void ip_64_value_set(number v) {
        this->ip_64_value = v;
        this->ip_64_fillSigBuf();
        this->ip_64_lastValue = v;
    }
    
    void eventinlet_70_out1_number_set(number v) {
        this->ip_64_value_set(v);
    }
    
    void ip_65_value_set(number v) {
        this->ip_65_value = v;
        this->ip_65_fillSigBuf();
        this->ip_65_lastValue = v;
    }
    
    void eventinlet_71_out1_number_set(number v) {
        this->ip_65_value_set(v);
    }
    
    void ip_62_value_set(number v) {
        this->ip_62_value = v;
        this->ip_62_fillSigBuf();
        this->ip_62_lastValue = v;
    }
    
    void eventinlet_68_out1_number_set(number v) {
        this->ip_62_value_set(v);
    }
    
    void ip_63_value_set(number v) {
        this->ip_63_value = v;
        this->ip_63_fillSigBuf();
        this->ip_63_lastValue = v;
    }
    
    void eventinlet_69_out1_number_set(number v) {
        this->ip_63_value_set(v);
    }
    
    void ip_66_value_set(number v) {
        this->ip_66_value = v;
        this->ip_66_fillSigBuf();
        this->ip_66_lastValue = v;
    }
    
    void eventinlet_72_out1_number_set(number v) {
        this->ip_66_value_set(v);
    }
    
    void ip_69_value_set(number v) {
        this->ip_69_value = v;
        this->ip_69_fillSigBuf();
        this->ip_69_lastValue = v;
    }
    
    void eventinlet_75_out1_number_set(number v) {
        this->ip_69_value_set(v);
    }
    
    void ip_70_value_set(number v) {
        this->ip_70_value = v;
        this->ip_70_fillSigBuf();
        this->ip_70_lastValue = v;
    }
    
    void eventinlet_76_out1_number_set(number v) {
        this->ip_70_value_set(v);
    }
    
    void ip_71_value_set(number v) {
        this->ip_71_value = v;
        this->ip_71_fillSigBuf();
        this->ip_71_lastValue = v;
    }
    
    void eventinlet_77_out1_number_set(number v) {
        this->ip_71_value_set(v);
    }
    
    void ip_67_value_set(number v) {
        this->ip_67_value = v;
        this->ip_67_fillSigBuf();
        this->ip_67_lastValue = v;
    }
    
    void eventinlet_73_out1_number_set(number v) {
        this->ip_67_value_set(v);
    }
    
    void ip_68_value_set(number v) {
        this->ip_68_value = v;
        this->ip_68_fillSigBuf();
        this->ip_68_lastValue = v;
    }
    
    void eventinlet_74_out1_number_set(number v) {
        this->ip_68_value_set(v);
    }
    
    void ip_72_value_set(number v) {
        this->ip_72_value = v;
        this->ip_72_fillSigBuf();
        this->ip_72_lastValue = v;
    }
    
    void eventinlet_78_out1_number_set(number v) {
        this->ip_72_value_set(v);
    }
    
    void click_06_click_number_set(number v) {
        for (SampleIndex i = (SampleIndex)(this->click_06_lastclick + 1); i < this->sampleOffsetIntoNextAudioBuffer; i++) {
            this->click_06_buf[(Index)i] = 0;
        }
    
        this->click_06_lastclick = this->sampleOffsetIntoNextAudioBuffer;
        this->click_06_buf[(Index)this->click_06_lastclick] = v;
    }
    
    void click_06_click_bang_bang() {
        this->click_06_click_number_set(1);
    }
    
    void eventinlet_66_out1_bang_bang() {
        this->click_06_click_bang_bang();
    }
    
    void eventinlet_66_out1_number_set(number v) {
        this->click_06_click_number_set(v);
    }
    
    template<typename LISTTYPE> void eventinlet_66_out1_list_set(const LISTTYPE& v) {
        {
            number converted = (v->length > 0 ? v[0] : 0);
            this->click_06_click_number_set(converted);
        }
    }
    
    void ip_61_value_bang() {
        number v = this->ip_61_value;
        this->ip_61_fillSigBuf();
        this->ip_61_lastValue = v;
    }
    
    void ip_61_impulse_set(number v) {
        this->ip_61_impulse = v;
        this->ip_61_fillSigBuf();
        this->ip_61_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_61_resetCount = lengthInSamples;
    }
    
    void ip_62_value_bang() {
        number v = this->ip_62_value;
        this->ip_62_fillSigBuf();
        this->ip_62_lastValue = v;
    }
    
    void ip_62_impulse_set(number v) {
        this->ip_62_impulse = v;
        this->ip_62_fillSigBuf();
        this->ip_62_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_62_resetCount = lengthInSamples;
    }
    
    void ip_63_value_bang() {
        number v = this->ip_63_value;
        this->ip_63_fillSigBuf();
        this->ip_63_lastValue = v;
    }
    
    void ip_63_impulse_set(number v) {
        this->ip_63_impulse = v;
        this->ip_63_fillSigBuf();
        this->ip_63_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_63_resetCount = lengthInSamples;
    }
    
    void ip_64_value_bang() {
        number v = this->ip_64_value;
        this->ip_64_fillSigBuf();
        this->ip_64_lastValue = v;
    }
    
    void ip_64_impulse_set(number v) {
        this->ip_64_impulse = v;
        this->ip_64_fillSigBuf();
        this->ip_64_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_64_resetCount = lengthInSamples;
    }
    
    void ip_65_value_bang() {
        number v = this->ip_65_value;
        this->ip_65_fillSigBuf();
        this->ip_65_lastValue = v;
    }
    
    void ip_65_impulse_set(number v) {
        this->ip_65_impulse = v;
        this->ip_65_fillSigBuf();
        this->ip_65_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_65_resetCount = lengthInSamples;
    }
    
    void ip_66_value_bang() {
        number v = this->ip_66_value;
        this->ip_66_fillSigBuf();
        this->ip_66_lastValue = v;
    }
    
    void ip_66_impulse_set(number v) {
        this->ip_66_impulse = v;
        this->ip_66_fillSigBuf();
        this->ip_66_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_66_resetCount = lengthInSamples;
    }
    
    void ip_67_value_bang() {
        number v = this->ip_67_value;
        this->ip_67_fillSigBuf();
        this->ip_67_lastValue = v;
    }
    
    void ip_67_impulse_set(number v) {
        this->ip_67_impulse = v;
        this->ip_67_fillSigBuf();
        this->ip_67_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_67_resetCount = lengthInSamples;
    }
    
    void ip_68_value_bang() {
        number v = this->ip_68_value;
        this->ip_68_fillSigBuf();
        this->ip_68_lastValue = v;
    }
    
    void ip_68_impulse_set(number v) {
        this->ip_68_impulse = v;
        this->ip_68_fillSigBuf();
        this->ip_68_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_68_resetCount = lengthInSamples;
    }
    
    void ip_69_value_bang() {
        number v = this->ip_69_value;
        this->ip_69_fillSigBuf();
        this->ip_69_lastValue = v;
    }
    
    void ip_69_impulse_set(number v) {
        this->ip_69_impulse = v;
        this->ip_69_fillSigBuf();
        this->ip_69_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_69_resetCount = lengthInSamples;
    }
    
    void ip_70_value_bang() {
        number v = this->ip_70_value;
        this->ip_70_fillSigBuf();
        this->ip_70_lastValue = v;
    }
    
    void ip_70_impulse_set(number v) {
        this->ip_70_impulse = v;
        this->ip_70_fillSigBuf();
        this->ip_70_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_70_resetCount = lengthInSamples;
    }
    
    void ip_71_value_bang() {
        number v = this->ip_71_value;
        this->ip_71_fillSigBuf();
        this->ip_71_lastValue = v;
    }
    
    void ip_71_impulse_set(number v) {
        this->ip_71_impulse = v;
        this->ip_71_fillSigBuf();
        this->ip_71_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_71_resetCount = lengthInSamples;
    }
    
    void ip_72_value_bang() {
        number v = this->ip_72_value;
        this->ip_72_fillSigBuf();
        this->ip_72_lastValue = v;
    }
    
    void ip_72_impulse_set(number v) {
        this->ip_72_impulse = v;
        this->ip_72_fillSigBuf();
        this->ip_72_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_72_resetCount = lengthInSamples;
    }
    
    void click_06_perform(SampleValue * out, Index n) {
        auto __click_06_lastclick = this->click_06_lastclick;
    
        for (SampleIndex i = 0; i <= __click_06_lastclick; i++) {
            out[(Index)i] = this->click_06_buf[(Index)i];
        }
    
        for (SampleIndex i = (SampleIndex)(__click_06_lastclick + 1); i < (SampleIndex)(n); i++) {
            out[(Index)i] = 0;
        }
    
        __click_06_lastclick = -1;
        this->click_06_lastclick = __click_06_lastclick;
    }
    
    void ip_61_perform(SampleValue * out, Index n) {
        auto __ip_61_lastValue = this->ip_61_lastValue;
        auto __ip_61_lastIndex = this->ip_61_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_61_lastIndex ? __ip_61_lastValue : this->ip_61_sigbuf[(Index)i]);
        }
    
        __ip_61_lastIndex = 0;
        this->ip_61_lastIndex = __ip_61_lastIndex;
    }
    
    void ip_62_perform(SampleValue * out, Index n) {
        auto __ip_62_lastValue = this->ip_62_lastValue;
        auto __ip_62_lastIndex = this->ip_62_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_62_lastIndex ? __ip_62_lastValue : this->ip_62_sigbuf[(Index)i]);
        }
    
        __ip_62_lastIndex = 0;
        this->ip_62_lastIndex = __ip_62_lastIndex;
    }
    
    void ip_63_perform(SampleValue * out, Index n) {
        auto __ip_63_lastValue = this->ip_63_lastValue;
        auto __ip_63_lastIndex = this->ip_63_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_63_lastIndex ? __ip_63_lastValue : this->ip_63_sigbuf[(Index)i]);
        }
    
        __ip_63_lastIndex = 0;
        this->ip_63_lastIndex = __ip_63_lastIndex;
    }
    
    void ip_64_perform(SampleValue * out, Index n) {
        auto __ip_64_lastValue = this->ip_64_lastValue;
        auto __ip_64_lastIndex = this->ip_64_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_64_lastIndex ? __ip_64_lastValue : this->ip_64_sigbuf[(Index)i]);
        }
    
        __ip_64_lastIndex = 0;
        this->ip_64_lastIndex = __ip_64_lastIndex;
    }
    
    void ip_65_perform(SampleValue * out, Index n) {
        auto __ip_65_lastValue = this->ip_65_lastValue;
        auto __ip_65_lastIndex = this->ip_65_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_65_lastIndex ? __ip_65_lastValue : this->ip_65_sigbuf[(Index)i]);
        }
    
        __ip_65_lastIndex = 0;
        this->ip_65_lastIndex = __ip_65_lastIndex;
    }
    
    void ip_66_perform(SampleValue * out, Index n) {
        auto __ip_66_lastValue = this->ip_66_lastValue;
        auto __ip_66_lastIndex = this->ip_66_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_66_lastIndex ? __ip_66_lastValue : this->ip_66_sigbuf[(Index)i]);
        }
    
        __ip_66_lastIndex = 0;
        this->ip_66_lastIndex = __ip_66_lastIndex;
    }
    
    void ip_67_perform(SampleValue * out, Index n) {
        auto __ip_67_lastValue = this->ip_67_lastValue;
        auto __ip_67_lastIndex = this->ip_67_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_67_lastIndex ? __ip_67_lastValue : this->ip_67_sigbuf[(Index)i]);
        }
    
        __ip_67_lastIndex = 0;
        this->ip_67_lastIndex = __ip_67_lastIndex;
    }
    
    void ip_68_perform(SampleValue * out, Index n) {
        auto __ip_68_lastValue = this->ip_68_lastValue;
        auto __ip_68_lastIndex = this->ip_68_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_68_lastIndex ? __ip_68_lastValue : this->ip_68_sigbuf[(Index)i]);
        }
    
        __ip_68_lastIndex = 0;
        this->ip_68_lastIndex = __ip_68_lastIndex;
    }
    
    void ip_69_perform(SampleValue * out, Index n) {
        auto __ip_69_lastValue = this->ip_69_lastValue;
        auto __ip_69_lastIndex = this->ip_69_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_69_lastIndex ? __ip_69_lastValue : this->ip_69_sigbuf[(Index)i]);
        }
    
        __ip_69_lastIndex = 0;
        this->ip_69_lastIndex = __ip_69_lastIndex;
    }
    
    void ip_70_perform(SampleValue * out, Index n) {
        auto __ip_70_lastValue = this->ip_70_lastValue;
        auto __ip_70_lastIndex = this->ip_70_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_70_lastIndex ? __ip_70_lastValue : this->ip_70_sigbuf[(Index)i]);
        }
    
        __ip_70_lastIndex = 0;
        this->ip_70_lastIndex = __ip_70_lastIndex;
    }
    
    void ip_71_perform(SampleValue * out, Index n) {
        auto __ip_71_lastValue = this->ip_71_lastValue;
        auto __ip_71_lastIndex = this->ip_71_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_71_lastIndex ? __ip_71_lastValue : this->ip_71_sigbuf[(Index)i]);
        }
    
        __ip_71_lastIndex = 0;
        this->ip_71_lastIndex = __ip_71_lastIndex;
    }
    
    void ip_72_perform(SampleValue * out, Index n) {
        auto __ip_72_lastValue = this->ip_72_lastValue;
        auto __ip_72_lastIndex = this->ip_72_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_72_lastIndex ? __ip_72_lastValue : this->ip_72_sigbuf[(Index)i]);
        }
    
        __ip_72_lastIndex = 0;
        this->ip_72_lastIndex = __ip_72_lastIndex;
    }
    
    void codebox_tilde_06_perform(
        const Sample * in1,
        const Sample * in2,
        const Sample * in3,
        const Sample * in4,
        const Sample * in5,
        const Sample * in6,
        const Sample * in7,
        const Sample * in8,
        const Sample * in9,
        const Sample * in10,
        const Sample * in11,
        const Sample * in12,
        const Sample * in13,
        SampleValue * out1,
        Index n
    ) {
        auto __codebox_tilde_06_noiseState = this->codebox_tilde_06_noiseState;
        auto __codebox_tilde_06_a3 = this->codebox_tilde_06_a3;
        auto __codebox_tilde_06_a2 = this->codebox_tilde_06_a2;
        auto __codebox_tilde_06_a1 = this->codebox_tilde_06_a1;
        auto __codebox_tilde_06_k = this->codebox_tilde_06_k;
        auto __codebox_tilde_06_noiseCoef = this->codebox_tilde_06_noiseCoef;
        auto __codebox_tilde_06_envCoef = this->codebox_tilde_06_envCoef;
        auto __codebox_tilde_06_ic2 = this->codebox_tilde_06_ic2;
        auto __codebox_tilde_06_ic1 = this->codebox_tilde_06_ic1;
        auto __codebox_tilde_06_modPhase = this->codebox_tilde_06_modPhase;
        auto __codebox_tilde_06_modePhase = this->codebox_tilde_06_modePhase;
        auto __codebox_tilde_06_phase = this->codebox_tilde_06_phase;
        auto __codebox_tilde_06_noiseEnv = this->codebox_tilde_06_noiseEnv;
        auto __codebox_tilde_06_env = this->codebox_tilde_06_env;
        auto __codebox_tilde_06_active = this->codebox_tilde_06_active;
        auto __codebox_tilde_06_hitLevel = this->codebox_tilde_06_hitLevel;
        auto __codebox_tilde_06_hitDrive = this->codebox_tilde_06_hitDrive;
        auto __codebox_tilde_06_hitFmRatio = this->codebox_tilde_06_hitFmRatio;
        auto __codebox_tilde_06_hitFmAmount = this->codebox_tilde_06_hitFmAmount;
        auto __codebox_tilde_06_hitFilterQ = this->codebox_tilde_06_hitFilterQ;
        auto __codebox_tilde_06_hitFilterHz = this->codebox_tilde_06_hitFilterHz;
        auto __codebox_tilde_06_hitNoiseDecayMs = this->codebox_tilde_06_hitNoiseDecayMs;
        auto __codebox_tilde_06_hitClickLevel = this->codebox_tilde_06_hitClickLevel;
        auto __codebox_tilde_06_hitModeLevel = this->codebox_tilde_06_hitModeLevel;
        auto __codebox_tilde_06_hitModeRatio = this->codebox_tilde_06_hitModeRatio;
        auto __codebox_tilde_06_hitDecayMs = this->codebox_tilde_06_hitDecayMs;
        auto __codebox_tilde_06_hitPitchHz = this->codebox_tilde_06_hitPitchHz;
        Index i;
    
        for (i = 0; i < (Index)n; i++) {
            number trig = in1[(Index)i];
            number sr = this->sr;
    
            if (trig > 0) {
                __codebox_tilde_06_hitPitchHz = in2[(Index)i];//#map:_###_obj_###_:32
                __codebox_tilde_06_hitDecayMs = in3[(Index)i];//#map:_###_obj_###_:33
                __codebox_tilde_06_hitModeRatio = in4[(Index)i];//#map:_###_obj_###_:34
                __codebox_tilde_06_hitModeLevel = in5[(Index)i];//#map:_###_obj_###_:35
                __codebox_tilde_06_hitClickLevel = in6[(Index)i];//#map:_###_obj_###_:36
                __codebox_tilde_06_hitNoiseDecayMs = in7[(Index)i];//#map:_###_obj_###_:37
                __codebox_tilde_06_hitFilterHz = in8[(Index)i];//#map:_###_obj_###_:38
                __codebox_tilde_06_hitFilterQ = in9[(Index)i];//#map:_###_obj_###_:39
                __codebox_tilde_06_hitFmAmount = in10[(Index)i];//#map:_###_obj_###_:40
                __codebox_tilde_06_hitFmRatio = in11[(Index)i];//#map:_###_obj_###_:41
                __codebox_tilde_06_hitDrive = in12[(Index)i];//#map:_###_obj_###_:42
                __codebox_tilde_06_hitLevel = in13[(Index)i];//#map:_###_obj_###_:43
            }//#map:_###_obj_###_:31
    
            if (trig > 0) {
                __codebox_tilde_06_active = 1;//#map:_###_obj_###_:46
                __codebox_tilde_06_env = 1;//#map:_###_obj_###_:47
                __codebox_tilde_06_noiseEnv = 1;//#map:_###_obj_###_:47
                __codebox_tilde_06_phase = 0;//#map:_###_obj_###_:47
                __codebox_tilde_06_modePhase = 0;//#map:_###_obj_###_:47
                __codebox_tilde_06_modPhase = 0;//#map:_###_obj_###_:47
                __codebox_tilde_06_ic1 = 0;//#map:_###_obj_###_:48
                __codebox_tilde_06_ic2 = 0;//#map:_###_obj_###_:48
    
                __codebox_tilde_06_envCoef = rnbo_exp(
                    (this->maximum(1, __codebox_tilde_06_hitDecayMs) * 0.001 * sr == 0. ? 0. : -6.907755 / (this->maximum(1, __codebox_tilde_06_hitDecayMs) * 0.001 * sr))
                );//#map:_###_obj_###_:49
    
                __codebox_tilde_06_noiseCoef = rnbo_exp(
                    (this->maximum(0.5, __codebox_tilde_06_hitNoiseDecayMs) * 0.001 * sr == 0. ? 0. : -6.907755 / (this->maximum(0.5, __codebox_tilde_06_hitNoiseDecayMs) * 0.001 * sr))
                );//#map:_###_obj_###_:50
    
                number g = rnbo_tan(
                    (sr == 0. ? 0. : 3.141592653589793 * ((__codebox_tilde_06_hitFilterHz > sr * 0.45 ? sr * 0.45 : (__codebox_tilde_06_hitFilterHz < 200 ? 200 : __codebox_tilde_06_hitFilterHz))) / sr)
                );
    
                __codebox_tilde_06_k = (this->maximum(0.5, __codebox_tilde_06_hitFilterQ) == 0. ? 0. : (number)1 / this->maximum(0.5, __codebox_tilde_06_hitFilterQ));//#map:_###_obj_###_:52
                __codebox_tilde_06_a1 = (1 + g * (g + __codebox_tilde_06_k) == 0. ? 0. : (number)1 / (1 + g * (g + __codebox_tilde_06_k)));//#map:_###_obj_###_:53
                __codebox_tilde_06_a2 = g * __codebox_tilde_06_a1;//#map:_###_obj_###_:53
                __codebox_tilde_06_a3 = g * __codebox_tilde_06_a2;//#map:_###_obj_###_:53
            }//#map:_###_obj_###_:45
    
            out1[(Index)i] = 0;//#map:_###_obj_###_:55
    
            if (__codebox_tilde_06_active > 0) {
                __codebox_tilde_06_env *= __codebox_tilde_06_envCoef;//#map:_###_obj_###_:57
                __codebox_tilde_06_noiseEnv *= __codebox_tilde_06_noiseCoef;//#map:_###_obj_###_:57
                number hz = (__codebox_tilde_06_hitPitchHz > sr * 0.2 ? sr * 0.2 : (__codebox_tilde_06_hitPitchHz < 100 ? 100 : __codebox_tilde_06_hitPitchHz));
                __codebox_tilde_06_phase = this->wrap(__codebox_tilde_06_phase + ((sr == 0. ? 0. : hz / sr)), 0, 1);//#map:_###_obj_###_:59
    
                __codebox_tilde_06_modePhase = this->wrap(
                    __codebox_tilde_06_modePhase + ((sr == 0. ? 0. : this->minimum(hz * __codebox_tilde_06_hitModeRatio, sr * 0.45) / sr)),
                    0,
                    1
                );//#map:_###_obj_###_:60
    
                __codebox_tilde_06_modPhase = this->wrap(
                    __codebox_tilde_06_modPhase + ((sr == 0. ? 0. : this->minimum(hz * __codebox_tilde_06_hitFmRatio, sr * 0.45) / sr)),
                    0,
                    1
                );//#map:_###_obj_###_:61
    
                number body = rnbo_sin(
                    __codebox_tilde_06_phase * 6.283185307179586 + rnbo_sin(__codebox_tilde_06_modPhase * 6.283185307179586) * __codebox_tilde_06_hitFmAmount * __codebox_tilde_06_env
                );
    
                number shell = rnbo_sin(__codebox_tilde_06_modePhase * 6.283185307179586);
                __codebox_tilde_06_noiseState = this->wrap((__codebox_tilde_06_noiseState + 1) * 16807, 0, 2147483647) - 1;//#map:_###_obj_###_:64
                number white = (__codebox_tilde_06_noiseState + 1) / (number)1073741823.5 - 1;
                number excitation = white * __codebox_tilde_06_noiseEnv;
                number v3 = excitation - __codebox_tilde_06_ic2;
                number band = __codebox_tilde_06_a1 * __codebox_tilde_06_ic1 + __codebox_tilde_06_a2 * v3;
                number low = __codebox_tilde_06_ic2 + __codebox_tilde_06_a2 * __codebox_tilde_06_ic1 + __codebox_tilde_06_a3 * v3;
                __codebox_tilde_06_ic1 = 2 * band - __codebox_tilde_06_ic1;//#map:_###_obj_###_:70
                __codebox_tilde_06_ic2 = 2 * low - __codebox_tilde_06_ic2;//#map:_###_obj_###_:70
                number high = excitation - __codebox_tilde_06_k * band - low;
                number raw = (body * 0.65 + shell * __codebox_tilde_06_hitModeLevel * 0.6) * __codebox_tilde_06_env + (band * __codebox_tilde_06_k + high * 0.2) * __codebox_tilde_06_hitClickLevel;
                auto drive = this->maximum(0.25, __codebox_tilde_06_hitDrive);
                out1[(Index)i] = ((rnbo_tanh(drive) == 0. ? 0. : rnbo_tanh(raw * drive) / rnbo_tanh(drive))) * ((__codebox_tilde_06_hitLevel > 1 ? 1 : (__codebox_tilde_06_hitLevel < 0 ? 0 : __codebox_tilde_06_hitLevel)));//#map:_###_obj_###_:74
    
                if (__codebox_tilde_06_env < 1e-7 && __codebox_tilde_06_noiseEnv < 1e-7 && rnbo_abs(__codebox_tilde_06_ic1) + rnbo_abs(__codebox_tilde_06_ic2) < 1e-7)
                    __codebox_tilde_06_active = 0;//#map:_###_obj_###_:75;//#map:_###_obj_###_:75
            }//#map:_###_obj_###_:56
        }
    
        this->codebox_tilde_06_hitPitchHz = __codebox_tilde_06_hitPitchHz;
        this->codebox_tilde_06_hitDecayMs = __codebox_tilde_06_hitDecayMs;
        this->codebox_tilde_06_hitModeRatio = __codebox_tilde_06_hitModeRatio;
        this->codebox_tilde_06_hitModeLevel = __codebox_tilde_06_hitModeLevel;
        this->codebox_tilde_06_hitClickLevel = __codebox_tilde_06_hitClickLevel;
        this->codebox_tilde_06_hitNoiseDecayMs = __codebox_tilde_06_hitNoiseDecayMs;
        this->codebox_tilde_06_hitFilterHz = __codebox_tilde_06_hitFilterHz;
        this->codebox_tilde_06_hitFilterQ = __codebox_tilde_06_hitFilterQ;
        this->codebox_tilde_06_hitFmAmount = __codebox_tilde_06_hitFmAmount;
        this->codebox_tilde_06_hitFmRatio = __codebox_tilde_06_hitFmRatio;
        this->codebox_tilde_06_hitDrive = __codebox_tilde_06_hitDrive;
        this->codebox_tilde_06_hitLevel = __codebox_tilde_06_hitLevel;
        this->codebox_tilde_06_active = __codebox_tilde_06_active;
        this->codebox_tilde_06_env = __codebox_tilde_06_env;
        this->codebox_tilde_06_noiseEnv = __codebox_tilde_06_noiseEnv;
        this->codebox_tilde_06_phase = __codebox_tilde_06_phase;
        this->codebox_tilde_06_modePhase = __codebox_tilde_06_modePhase;
        this->codebox_tilde_06_modPhase = __codebox_tilde_06_modPhase;
        this->codebox_tilde_06_ic1 = __codebox_tilde_06_ic1;
        this->codebox_tilde_06_ic2 = __codebox_tilde_06_ic2;
        this->codebox_tilde_06_envCoef = __codebox_tilde_06_envCoef;
        this->codebox_tilde_06_noiseCoef = __codebox_tilde_06_noiseCoef;
        this->codebox_tilde_06_k = __codebox_tilde_06_k;
        this->codebox_tilde_06_a1 = __codebox_tilde_06_a1;
        this->codebox_tilde_06_a2 = __codebox_tilde_06_a2;
        this->codebox_tilde_06_a3 = __codebox_tilde_06_a3;
        this->codebox_tilde_06_noiseState = __codebox_tilde_06_noiseState;
    }
    
    void dspexpr_06_perform(const Sample * in1, number in2, SampleValue * out1, Index n) {
        RNBO_UNUSED(in2);
        Index i;
    
        for (i = 0; i < (Index)n; i++) {
            out1[(Index)i] = in1[(Index)i] * 1;//#map:_###_obj_###_:1
        }
    }
    
    void signalforwarder_11_perform(const SampleValue * input, SampleValue * output, Index n) {
        copySignal(output, input, n);
    }
    
    void signalforwarder_12_perform(const SampleValue * input, SampleValue * output, Index n) {
        copySignal(output, input, n);
    }
    
    void stackprotect_perform(Index n) {
        RNBO_UNUSED(n);
        auto __stackprotect_count = this->stackprotect_count;
        __stackprotect_count = 0;
        this->stackprotect_count = __stackprotect_count;
    }
    
    void ip_61_init() {
        this->ip_61_lastValue = this->ip_61_value;
    }
    
    void ip_61_fillSigBuf() {
        if ((bool)(this->ip_61_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_61_lastIndex); i < k; i++) {
                if (this->ip_61_resetCount > 0) {
                    this->ip_61_sigbuf[(Index)i] = 1;
                    this->ip_61_resetCount--;
                } else {
                    this->ip_61_sigbuf[(Index)i] = this->ip_61_lastValue;
                }
            }
    
            this->ip_61_lastIndex = k;
        }
    }
    
    void ip_61_dspsetup(bool force) {
        if ((bool)(this->ip_61_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_61_lastIndex = 0;
        this->ip_61_setupDone = true;
    }
    
    void ip_62_init() {
        this->ip_62_lastValue = this->ip_62_value;
    }
    
    void ip_62_fillSigBuf() {
        if ((bool)(this->ip_62_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_62_lastIndex); i < k; i++) {
                if (this->ip_62_resetCount > 0) {
                    this->ip_62_sigbuf[(Index)i] = 1;
                    this->ip_62_resetCount--;
                } else {
                    this->ip_62_sigbuf[(Index)i] = this->ip_62_lastValue;
                }
            }
    
            this->ip_62_lastIndex = k;
        }
    }
    
    void ip_62_dspsetup(bool force) {
        if ((bool)(this->ip_62_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_62_lastIndex = 0;
        this->ip_62_setupDone = true;
    }
    
    void ip_63_init() {
        this->ip_63_lastValue = this->ip_63_value;
    }
    
    void ip_63_fillSigBuf() {
        if ((bool)(this->ip_63_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_63_lastIndex); i < k; i++) {
                if (this->ip_63_resetCount > 0) {
                    this->ip_63_sigbuf[(Index)i] = 1;
                    this->ip_63_resetCount--;
                } else {
                    this->ip_63_sigbuf[(Index)i] = this->ip_63_lastValue;
                }
            }
    
            this->ip_63_lastIndex = k;
        }
    }
    
    void ip_63_dspsetup(bool force) {
        if ((bool)(this->ip_63_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_63_lastIndex = 0;
        this->ip_63_setupDone = true;
    }
    
    void ip_64_init() {
        this->ip_64_lastValue = this->ip_64_value;
    }
    
    void ip_64_fillSigBuf() {
        if ((bool)(this->ip_64_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_64_lastIndex); i < k; i++) {
                if (this->ip_64_resetCount > 0) {
                    this->ip_64_sigbuf[(Index)i] = 1;
                    this->ip_64_resetCount--;
                } else {
                    this->ip_64_sigbuf[(Index)i] = this->ip_64_lastValue;
                }
            }
    
            this->ip_64_lastIndex = k;
        }
    }
    
    void ip_64_dspsetup(bool force) {
        if ((bool)(this->ip_64_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_64_lastIndex = 0;
        this->ip_64_setupDone = true;
    }
    
    void ip_65_init() {
        this->ip_65_lastValue = this->ip_65_value;
    }
    
    void ip_65_fillSigBuf() {
        if ((bool)(this->ip_65_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_65_lastIndex); i < k; i++) {
                if (this->ip_65_resetCount > 0) {
                    this->ip_65_sigbuf[(Index)i] = 1;
                    this->ip_65_resetCount--;
                } else {
                    this->ip_65_sigbuf[(Index)i] = this->ip_65_lastValue;
                }
            }
    
            this->ip_65_lastIndex = k;
        }
    }
    
    void ip_65_dspsetup(bool force) {
        if ((bool)(this->ip_65_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_65_lastIndex = 0;
        this->ip_65_setupDone = true;
    }
    
    void ip_66_init() {
        this->ip_66_lastValue = this->ip_66_value;
    }
    
    void ip_66_fillSigBuf() {
        if ((bool)(this->ip_66_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_66_lastIndex); i < k; i++) {
                if (this->ip_66_resetCount > 0) {
                    this->ip_66_sigbuf[(Index)i] = 1;
                    this->ip_66_resetCount--;
                } else {
                    this->ip_66_sigbuf[(Index)i] = this->ip_66_lastValue;
                }
            }
    
            this->ip_66_lastIndex = k;
        }
    }
    
    void ip_66_dspsetup(bool force) {
        if ((bool)(this->ip_66_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_66_lastIndex = 0;
        this->ip_66_setupDone = true;
    }
    
    void ip_67_init() {
        this->ip_67_lastValue = this->ip_67_value;
    }
    
    void ip_67_fillSigBuf() {
        if ((bool)(this->ip_67_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_67_lastIndex); i < k; i++) {
                if (this->ip_67_resetCount > 0) {
                    this->ip_67_sigbuf[(Index)i] = 1;
                    this->ip_67_resetCount--;
                } else {
                    this->ip_67_sigbuf[(Index)i] = this->ip_67_lastValue;
                }
            }
    
            this->ip_67_lastIndex = k;
        }
    }
    
    void ip_67_dspsetup(bool force) {
        if ((bool)(this->ip_67_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_67_lastIndex = 0;
        this->ip_67_setupDone = true;
    }
    
    void ip_68_init() {
        this->ip_68_lastValue = this->ip_68_value;
    }
    
    void ip_68_fillSigBuf() {
        if ((bool)(this->ip_68_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_68_lastIndex); i < k; i++) {
                if (this->ip_68_resetCount > 0) {
                    this->ip_68_sigbuf[(Index)i] = 1;
                    this->ip_68_resetCount--;
                } else {
                    this->ip_68_sigbuf[(Index)i] = this->ip_68_lastValue;
                }
            }
    
            this->ip_68_lastIndex = k;
        }
    }
    
    void ip_68_dspsetup(bool force) {
        if ((bool)(this->ip_68_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_68_lastIndex = 0;
        this->ip_68_setupDone = true;
    }
    
    void ip_69_init() {
        this->ip_69_lastValue = this->ip_69_value;
    }
    
    void ip_69_fillSigBuf() {
        if ((bool)(this->ip_69_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_69_lastIndex); i < k; i++) {
                if (this->ip_69_resetCount > 0) {
                    this->ip_69_sigbuf[(Index)i] = 1;
                    this->ip_69_resetCount--;
                } else {
                    this->ip_69_sigbuf[(Index)i] = this->ip_69_lastValue;
                }
            }
    
            this->ip_69_lastIndex = k;
        }
    }
    
    void ip_69_dspsetup(bool force) {
        if ((bool)(this->ip_69_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_69_lastIndex = 0;
        this->ip_69_setupDone = true;
    }
    
    void ip_70_init() {
        this->ip_70_lastValue = this->ip_70_value;
    }
    
    void ip_70_fillSigBuf() {
        if ((bool)(this->ip_70_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_70_lastIndex); i < k; i++) {
                if (this->ip_70_resetCount > 0) {
                    this->ip_70_sigbuf[(Index)i] = 1;
                    this->ip_70_resetCount--;
                } else {
                    this->ip_70_sigbuf[(Index)i] = this->ip_70_lastValue;
                }
            }
    
            this->ip_70_lastIndex = k;
        }
    }
    
    void ip_70_dspsetup(bool force) {
        if ((bool)(this->ip_70_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_70_lastIndex = 0;
        this->ip_70_setupDone = true;
    }
    
    void ip_71_init() {
        this->ip_71_lastValue = this->ip_71_value;
    }
    
    void ip_71_fillSigBuf() {
        if ((bool)(this->ip_71_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_71_lastIndex); i < k; i++) {
                if (this->ip_71_resetCount > 0) {
                    this->ip_71_sigbuf[(Index)i] = 1;
                    this->ip_71_resetCount--;
                } else {
                    this->ip_71_sigbuf[(Index)i] = this->ip_71_lastValue;
                }
            }
    
            this->ip_71_lastIndex = k;
        }
    }
    
    void ip_71_dspsetup(bool force) {
        if ((bool)(this->ip_71_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_71_lastIndex = 0;
        this->ip_71_setupDone = true;
    }
    
    void ip_72_init() {
        this->ip_72_lastValue = this->ip_72_value;
    }
    
    void ip_72_fillSigBuf() {
        if ((bool)(this->ip_72_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_72_lastIndex); i < k; i++) {
                if (this->ip_72_resetCount > 0) {
                    this->ip_72_sigbuf[(Index)i] = 1;
                    this->ip_72_resetCount--;
                } else {
                    this->ip_72_sigbuf[(Index)i] = this->ip_72_lastValue;
                }
            }
    
            this->ip_72_lastIndex = k;
        }
    }
    
    void ip_72_dspsetup(bool force) {
        if ((bool)(this->ip_72_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_72_lastIndex = 0;
        this->ip_72_setupDone = true;
    }
    
    bool stackprotect_check() {
        this->stackprotect_count++;
    
        if (this->stackprotect_count > 128) {
            console->log("STACK OVERFLOW DETECTED - stopped processing branch !");
            return true;
        }
    
        return false;
    }
    
    Index getPatcherSerial() const {
        return 0;
    }
    
    void sendParameter(ParameterIndex index, bool ignoreValue) {
        this->getPatcher()->sendParameter(index + this->parameterOffset, ignoreValue);
    }
    
    void scheduleParamInit(ParameterIndex index, Index order) {
        this->getPatcher()->scheduleParamInit(index + this->parameterOffset, order);
    }
    
    void updateTime(MillisecondTime time, EXTERNALENGINE* engine, bool inProcess = false) {
        RNBO_UNUSED(inProcess);
        RNBO_UNUSED(engine);
        this->_currentTime = time;
        auto offset = rnbo_fround(this->msToSamps(time - this->getEngine()->getCurrentTime(), this->sr));
    
        if (offset >= (SampleIndex)(this->vs))
            offset = (SampleIndex)(this->vs) - 1;
    
        if (offset < 0)
            offset = 0;
    
        this->sampleOffsetIntoNextAudioBuffer = (Index)(offset);
    }
    
    void assign_defaults()
    {
        ip_61_value = 0;
        ip_61_impulse = 0;
        ip_62_value = 0;
        ip_62_impulse = 0;
        ip_63_value = 0;
        ip_63_impulse = 0;
        ip_64_value = 0;
        ip_64_impulse = 0;
        ip_65_value = 0;
        ip_65_impulse = 0;
        ip_66_value = 0;
        ip_66_impulse = 0;
        ip_67_value = 0;
        ip_67_impulse = 0;
        ip_68_value = 0;
        ip_68_impulse = 0;
        ip_69_value = 0;
        ip_69_impulse = 0;
        ip_70_value = 0;
        ip_70_impulse = 0;
        ip_71_value = 0;
        ip_71_impulse = 0;
        ip_72_value = 0;
        ip_72_impulse = 0;
        codebox_tilde_06_in1 = 0;
        codebox_tilde_06_in2 = 0;
        codebox_tilde_06_in3 = 0;
        codebox_tilde_06_in4 = 0;
        codebox_tilde_06_in5 = 0;
        codebox_tilde_06_in6 = 0;
        codebox_tilde_06_in7 = 0;
        codebox_tilde_06_in8 = 0;
        codebox_tilde_06_in9 = 0;
        codebox_tilde_06_in10 = 0;
        codebox_tilde_06_in11 = 0;
        codebox_tilde_06_in12 = 0;
        codebox_tilde_06_in13 = 0;
        dspexpr_06_in1 = 0;
        dspexpr_06_in2 = 1;
        _currentTime = 0;
        audioProcessSampleCount = 0;
        sampleOffsetIntoNextAudioBuffer = 0;
        zeroBuffer = nullptr;
        dummyBuffer = nullptr;
        signals[0] = nullptr;
        signals[1] = nullptr;
        signals[2] = nullptr;
        signals[3] = nullptr;
        signals[4] = nullptr;
        signals[5] = nullptr;
        signals[6] = nullptr;
        signals[7] = nullptr;
        signals[8] = nullptr;
        signals[9] = nullptr;
        signals[10] = nullptr;
        signals[11] = nullptr;
        signals[12] = nullptr;
        signals[13] = nullptr;
        didAllocateSignals = 0;
        vs = 0;
        maxvs = 0;
        sr = 44100;
        invsr = 0.000022675736961451248;
        click_06_lastclick = -1;
        click_06_buf = nullptr;
        ip_61_lastIndex = 0;
        ip_61_lastValue = 0;
        ip_61_resetCount = 0;
        ip_61_sigbuf = nullptr;
        ip_61_setupDone = false;
        ip_62_lastIndex = 0;
        ip_62_lastValue = 0;
        ip_62_resetCount = 0;
        ip_62_sigbuf = nullptr;
        ip_62_setupDone = false;
        ip_63_lastIndex = 0;
        ip_63_lastValue = 0;
        ip_63_resetCount = 0;
        ip_63_sigbuf = nullptr;
        ip_63_setupDone = false;
        ip_64_lastIndex = 0;
        ip_64_lastValue = 0;
        ip_64_resetCount = 0;
        ip_64_sigbuf = nullptr;
        ip_64_setupDone = false;
        ip_65_lastIndex = 0;
        ip_65_lastValue = 0;
        ip_65_resetCount = 0;
        ip_65_sigbuf = nullptr;
        ip_65_setupDone = false;
        ip_66_lastIndex = 0;
        ip_66_lastValue = 0;
        ip_66_resetCount = 0;
        ip_66_sigbuf = nullptr;
        ip_66_setupDone = false;
        ip_67_lastIndex = 0;
        ip_67_lastValue = 0;
        ip_67_resetCount = 0;
        ip_67_sigbuf = nullptr;
        ip_67_setupDone = false;
        ip_68_lastIndex = 0;
        ip_68_lastValue = 0;
        ip_68_resetCount = 0;
        ip_68_sigbuf = nullptr;
        ip_68_setupDone = false;
        ip_69_lastIndex = 0;
        ip_69_lastValue = 0;
        ip_69_resetCount = 0;
        ip_69_sigbuf = nullptr;
        ip_69_setupDone = false;
        ip_70_lastIndex = 0;
        ip_70_lastValue = 0;
        ip_70_resetCount = 0;
        ip_70_sigbuf = nullptr;
        ip_70_setupDone = false;
        ip_71_lastIndex = 0;
        ip_71_lastValue = 0;
        ip_71_resetCount = 0;
        ip_71_sigbuf = nullptr;
        ip_71_setupDone = false;
        ip_72_lastIndex = 0;
        ip_72_lastValue = 0;
        ip_72_resetCount = 0;
        ip_72_sigbuf = nullptr;
        ip_72_setupDone = false;
        codebox_tilde_06_hitPitchHz = 850;
        codebox_tilde_06_hitDecayMs = 65;
        codebox_tilde_06_hitModeRatio = 2.73;
        codebox_tilde_06_hitModeLevel = 0.65;
        codebox_tilde_06_hitClickLevel = 0.6;
        codebox_tilde_06_hitNoiseDecayMs = 4;
        codebox_tilde_06_hitFilterHz = 4200;
        codebox_tilde_06_hitFilterQ = 1.2;
        codebox_tilde_06_hitFmAmount = 0.2;
        codebox_tilde_06_hitFmRatio = 2;
        codebox_tilde_06_hitDrive = 1.8;
        codebox_tilde_06_hitLevel = 0.45;
        codebox_tilde_06_active = 0;
        codebox_tilde_06_env = 0;
        codebox_tilde_06_noiseEnv = 0;
        codebox_tilde_06_envCoef = 0;
        codebox_tilde_06_noiseCoef = 0;
        codebox_tilde_06_phase = 0;
        codebox_tilde_06_modePhase = 0;
        codebox_tilde_06_modPhase = 0;
        codebox_tilde_06_noiseState = 23455;
        codebox_tilde_06_ic1 = 0;
        codebox_tilde_06_ic2 = 0;
        codebox_tilde_06_k = 1;
        codebox_tilde_06_a1 = 1;
        codebox_tilde_06_a2 = 0;
        codebox_tilde_06_a3 = 0;
        stackprotect_count = 0;
        _voiceIndex = 0;
        _noteNumber = 0;
        isMuted = 1;
        parameterOffset = 0;
    }
    
    // member variables
    
        number ip_61_value;
        number ip_61_impulse;
        number ip_62_value;
        number ip_62_impulse;
        number ip_63_value;
        number ip_63_impulse;
        number ip_64_value;
        number ip_64_impulse;
        number ip_65_value;
        number ip_65_impulse;
        number ip_66_value;
        number ip_66_impulse;
        number ip_67_value;
        number ip_67_impulse;
        number ip_68_value;
        number ip_68_impulse;
        number ip_69_value;
        number ip_69_impulse;
        number ip_70_value;
        number ip_70_impulse;
        number ip_71_value;
        number ip_71_impulse;
        number ip_72_value;
        number ip_72_impulse;
        number codebox_tilde_06_in1;
        number codebox_tilde_06_in2;
        number codebox_tilde_06_in3;
        number codebox_tilde_06_in4;
        number codebox_tilde_06_in5;
        number codebox_tilde_06_in6;
        number codebox_tilde_06_in7;
        number codebox_tilde_06_in8;
        number codebox_tilde_06_in9;
        number codebox_tilde_06_in10;
        number codebox_tilde_06_in11;
        number codebox_tilde_06_in12;
        number codebox_tilde_06_in13;
        number dspexpr_06_in1;
        number dspexpr_06_in2;
        MillisecondTime _currentTime;
        UInt64 audioProcessSampleCount;
        Index sampleOffsetIntoNextAudioBuffer;
        signal zeroBuffer;
        signal dummyBuffer;
        SampleValue * signals[14];
        bool didAllocateSignals;
        Index vs;
        Index maxvs;
        number sr;
        number invsr;
        SampleIndex click_06_lastclick;
        signal click_06_buf;
        SampleIndex ip_61_lastIndex;
        number ip_61_lastValue;
        SampleIndex ip_61_resetCount;
        signal ip_61_sigbuf;
        bool ip_61_setupDone;
        SampleIndex ip_62_lastIndex;
        number ip_62_lastValue;
        SampleIndex ip_62_resetCount;
        signal ip_62_sigbuf;
        bool ip_62_setupDone;
        SampleIndex ip_63_lastIndex;
        number ip_63_lastValue;
        SampleIndex ip_63_resetCount;
        signal ip_63_sigbuf;
        bool ip_63_setupDone;
        SampleIndex ip_64_lastIndex;
        number ip_64_lastValue;
        SampleIndex ip_64_resetCount;
        signal ip_64_sigbuf;
        bool ip_64_setupDone;
        SampleIndex ip_65_lastIndex;
        number ip_65_lastValue;
        SampleIndex ip_65_resetCount;
        signal ip_65_sigbuf;
        bool ip_65_setupDone;
        SampleIndex ip_66_lastIndex;
        number ip_66_lastValue;
        SampleIndex ip_66_resetCount;
        signal ip_66_sigbuf;
        bool ip_66_setupDone;
        SampleIndex ip_67_lastIndex;
        number ip_67_lastValue;
        SampleIndex ip_67_resetCount;
        signal ip_67_sigbuf;
        bool ip_67_setupDone;
        SampleIndex ip_68_lastIndex;
        number ip_68_lastValue;
        SampleIndex ip_68_resetCount;
        signal ip_68_sigbuf;
        bool ip_68_setupDone;
        SampleIndex ip_69_lastIndex;
        number ip_69_lastValue;
        SampleIndex ip_69_resetCount;
        signal ip_69_sigbuf;
        bool ip_69_setupDone;
        SampleIndex ip_70_lastIndex;
        number ip_70_lastValue;
        SampleIndex ip_70_resetCount;
        signal ip_70_sigbuf;
        bool ip_70_setupDone;
        SampleIndex ip_71_lastIndex;
        number ip_71_lastValue;
        SampleIndex ip_71_resetCount;
        signal ip_71_sigbuf;
        bool ip_71_setupDone;
        SampleIndex ip_72_lastIndex;
        number ip_72_lastValue;
        SampleIndex ip_72_resetCount;
        signal ip_72_sigbuf;
        bool ip_72_setupDone;
        number codebox_tilde_06_hitPitchHz;
        number codebox_tilde_06_hitDecayMs;
        number codebox_tilde_06_hitModeRatio;
        number codebox_tilde_06_hitModeLevel;
        number codebox_tilde_06_hitClickLevel;
        number codebox_tilde_06_hitNoiseDecayMs;
        number codebox_tilde_06_hitFilterHz;
        number codebox_tilde_06_hitFilterQ;
        number codebox_tilde_06_hitFmAmount;
        number codebox_tilde_06_hitFmRatio;
        number codebox_tilde_06_hitDrive;
        number codebox_tilde_06_hitLevel;
        number codebox_tilde_06_active;
        number codebox_tilde_06_env;
        number codebox_tilde_06_noiseEnv;
        number codebox_tilde_06_envCoef;
        number codebox_tilde_06_noiseCoef;
        number codebox_tilde_06_phase;
        number codebox_tilde_06_modePhase;
        number codebox_tilde_06_modPhase;
        number codebox_tilde_06_noiseState;
        number codebox_tilde_06_ic1;
        number codebox_tilde_06_ic2;
        number codebox_tilde_06_k;
        number codebox_tilde_06_a1;
        number codebox_tilde_06_a2;
        number codebox_tilde_06_a3;
        number stackprotect_count;
        Index _voiceIndex;
        Int _noteNumber;
        Index isMuted;
        ParameterIndex parameterOffset;
        bool _isInitialized = false;
};

class RNBOSubpatcher_124 : public PatcherInterfaceImpl {
    
    friend class rnbomatic;
    
    public:
    
    RNBOSubpatcher_124()
    {}
    
    ~RNBOSubpatcher_124()
    {
        deallocateSignals();
    }
    
    Index getNumMidiInputPorts() const {
        return 0;
    }
    
    void processMidiEvent(MillisecondTime , int , ConstByteArray , Index ) {}
    
    Index getNumMidiOutputPorts() const {
        return 0;
    }
    
    void process(
        const SampleValue * const* inputs,
        Index numInputs,
        SampleValue * const* outputs,
        Index numOutputs,
        Index n
    ) {
        RNBO_UNUSED(numInputs);
        RNBO_UNUSED(inputs);
        this->vs = n;
        this->updateTime(this->getEngine()->getCurrentTime(), (ENGINE*)nullptr, true);
        SampleValue * out1 = (numOutputs >= 1 && outputs[0] ? outputs[0] : this->dummyBuffer);
        SampleValue * out2 = (numOutputs >= 2 && outputs[1] ? outputs[1] : this->dummyBuffer);
        this->click_07_perform(this->signals[0], n);
        this->ip_73_perform(this->signals[1], n);
        this->ip_74_perform(this->signals[2], n);
        this->ip_75_perform(this->signals[3], n);
        this->ip_76_perform(this->signals[4], n);
        this->ip_77_perform(this->signals[5], n);
        this->ip_78_perform(this->signals[6], n);
        this->ip_79_perform(this->signals[7], n);
        this->ip_80_perform(this->signals[8], n);
        this->ip_81_perform(this->signals[9], n);
        this->ip_82_perform(this->signals[10], n);
        this->ip_83_perform(this->signals[11], n);
        this->ip_84_perform(this->signals[12], n);
    
        this->codebox_tilde_07_perform(
            this->signals[0],
            this->signals[1],
            this->signals[2],
            this->signals[3],
            this->signals[4],
            this->signals[5],
            this->signals[6],
            this->signals[7],
            this->signals[8],
            this->signals[9],
            this->signals[10],
            this->signals[11],
            this->signals[12],
            this->signals[13],
            n
        );
    
        this->dspexpr_07_perform(this->signals[13], this->dspexpr_07_in2, this->signals[12], n);
        this->signalforwarder_13_perform(this->signals[12], out2, n);
        this->signalforwarder_14_perform(this->signals[12], out1, n);
        this->stackprotect_perform(n);
        this->audioProcessSampleCount += this->vs;
    }
    
    void prepareToProcess(number sampleRate, Index maxBlockSize, bool force) {
        RNBO_ASSERT(this->_isInitialized);
    
        if (this->maxvs < maxBlockSize || !this->didAllocateSignals) {
            Index i;
    
            for (i = 0; i < 14; i++) {
                this->signals[i] = resizeSignal(this->signals[i], this->maxvs, maxBlockSize);
            }
    
            this->click_07_buf = resizeSignal(this->click_07_buf, this->maxvs, maxBlockSize);
            this->ip_73_sigbuf = resizeSignal(this->ip_73_sigbuf, this->maxvs, maxBlockSize);
            this->ip_74_sigbuf = resizeSignal(this->ip_74_sigbuf, this->maxvs, maxBlockSize);
            this->ip_75_sigbuf = resizeSignal(this->ip_75_sigbuf, this->maxvs, maxBlockSize);
            this->ip_76_sigbuf = resizeSignal(this->ip_76_sigbuf, this->maxvs, maxBlockSize);
            this->ip_77_sigbuf = resizeSignal(this->ip_77_sigbuf, this->maxvs, maxBlockSize);
            this->ip_78_sigbuf = resizeSignal(this->ip_78_sigbuf, this->maxvs, maxBlockSize);
            this->ip_79_sigbuf = resizeSignal(this->ip_79_sigbuf, this->maxvs, maxBlockSize);
            this->ip_80_sigbuf = resizeSignal(this->ip_80_sigbuf, this->maxvs, maxBlockSize);
            this->ip_81_sigbuf = resizeSignal(this->ip_81_sigbuf, this->maxvs, maxBlockSize);
            this->ip_82_sigbuf = resizeSignal(this->ip_82_sigbuf, this->maxvs, maxBlockSize);
            this->ip_83_sigbuf = resizeSignal(this->ip_83_sigbuf, this->maxvs, maxBlockSize);
            this->ip_84_sigbuf = resizeSignal(this->ip_84_sigbuf, this->maxvs, maxBlockSize);
            this->zeroBuffer = resizeSignal(this->zeroBuffer, this->maxvs, maxBlockSize);
            this->dummyBuffer = resizeSignal(this->dummyBuffer, this->maxvs, maxBlockSize);
            this->didAllocateSignals = true;
        }
    
        const bool sampleRateChanged = sampleRate != this->sr;
        const bool maxvsChanged = maxBlockSize != this->maxvs;
        const bool forceDSPSetup = sampleRateChanged || maxvsChanged || force;
    
        if (sampleRateChanged || maxvsChanged) {
            this->vs = maxBlockSize;
            this->maxvs = maxBlockSize;
            this->sr = sampleRate;
            this->invsr = 1 / sampleRate;
        }
    
        this->ip_73_dspsetup(forceDSPSetup);
        this->ip_74_dspsetup(forceDSPSetup);
        this->ip_75_dspsetup(forceDSPSetup);
        this->ip_76_dspsetup(forceDSPSetup);
        this->ip_77_dspsetup(forceDSPSetup);
        this->ip_78_dspsetup(forceDSPSetup);
        this->ip_79_dspsetup(forceDSPSetup);
        this->ip_80_dspsetup(forceDSPSetup);
        this->ip_81_dspsetup(forceDSPSetup);
        this->ip_82_dspsetup(forceDSPSetup);
        this->ip_83_dspsetup(forceDSPSetup);
        this->ip_84_dspsetup(forceDSPSetup);
    
        if (sampleRateChanged)
            this->onSampleRateChanged(sampleRate);
    }
    
    number msToSamps(MillisecondTime ms, number sampleRate) {
        return ms * sampleRate * 0.001;
    }
    
    MillisecondTime sampsToMs(SampleIndex samps) {
        return samps * (this->invsr * 1000);
    }
    
    Index getNumInputChannels() const {
        return 0;
    }
    
    Index getNumOutputChannels() const {
        return 2;
    }
    
    void getPreset(PatcherStateInterface& ) {}
    
    void setPreset(MillisecondTime , PatcherStateInterface& ) {}
    
    void setParameterValue(ParameterIndex , ParameterValue , MillisecondTime ) {}
    
    void processParameterEvent(ParameterIndex index, ParameterValue value, MillisecondTime time) {
        this->setParameterValue(index, value, time);
    }
    
    void processParameterBangEvent(ParameterIndex index, MillisecondTime time) {
        this->setParameterValue(index, this->getParameterValue(index), time);
    }
    
    void processNormalizedParameterEvent(ParameterIndex index, ParameterValue value, MillisecondTime time) {
        this->setParameterValueNormalized(index, value, time);
    }
    
    ParameterValue getParameterValue(ParameterIndex index)  {
        switch (index) {
        default:
            {
            return 0;
            }
        }
    }
    
    ParameterIndex getNumSignalInParameters() const {
        return 0;
    }
    
    ParameterIndex getNumSignalOutParameters() const {
        return 0;
    }
    
    ParameterIndex getNumParameters() const {
        return 0;
    }
    
    ConstCharPointer getParameterName(ParameterIndex index) const {
        switch (index) {
        default:
            {
            return "bogus";
            }
        }
    }
    
    ConstCharPointer getParameterId(ParameterIndex index) const {
        switch (index) {
        default:
            {
            return "bogus";
            }
        }
    }
    
    void getParameterInfo(ParameterIndex , ParameterInfo * ) const {}
    
    ParameterValue applyStepsToNormalizedParameterValue(ParameterValue normalizedValue, int steps) const {
        if (steps == 1) {
            if (normalizedValue > 0) {
                normalizedValue = 1.;
            }
        } else {
            ParameterValue oneStep = (number)1. / (steps - 1);
            ParameterValue numberOfSteps = rnbo_fround(normalizedValue / oneStep * 1 / (number)1) * (number)1;
            normalizedValue = numberOfSteps * oneStep;
        }
    
        return normalizedValue;
    }
    
    ParameterValue convertToNormalizedParameterValue(ParameterIndex index, ParameterValue value) const {
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    ParameterValue convertFromNormalizedParameterValue(ParameterIndex index, ParameterValue value) const {
        value = (value < 0 ? 0 : (value > 1 ? 1 : value));
    
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    ParameterValue constrainParameterValue(ParameterIndex index, ParameterValue value) const {
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    void processNumMessage(MessageTag , MessageTag , MillisecondTime , number ) {}
    
    void processListMessage(MessageTag , MessageTag , MillisecondTime , const list& ) {}
    
    void processBangMessage(MessageTag , MessageTag , MillisecondTime ) {}
    
    MessageTagInfo resolveTag(MessageTag tag) const {
        switch (tag) {
    
        }
    
        return nullptr;
    }
    
    DataRef* getDataRef(DataRefIndex index)  {
        switch (index) {
        default:
            {
            return nullptr;
            }
        }
    }
    
    DataRefIndex getNumDataRefs() const {
        return 0;
    }
    
    void processDataViewUpdate(DataRefIndex , MillisecondTime ) {}
    
    void initialize() {
        RNBO_ASSERT(!this->_isInitialized);
        this->assign_defaults();
        this->applyState();
        this->_isInitialized = true;
    }
    
    protected:
    
    void updateTime(MillisecondTime time, INTERNALENGINE*, bool inProcess = false) {
    	if (time == TimeNow) time = getTopLevelPatcher()->getPatcherTime();
    	getTopLevelPatcher()->processInternalEvents(time);
    	updateTime(time, (EXTERNALENGINE*)nullptr);
    }
    
    RNBOSubpatcher_124* operator->() {
        return this;
    }
    const RNBOSubpatcher_124* operator->() const {
        return this;
    }
    virtual rnbomatic* getPatcher() const {
        return static_cast<rnbomatic *>(_parentPatcher);
    }
    
    rnbomatic* getTopLevelPatcher() {
        return this->getPatcher()->getTopLevelPatcher();
    }
    
    void cancelClockEvents()
    {
    }
    
    number maximum(number x, number y) {
        return (x < y ? y : x);
    }
    
    number minimum(number x, number y) {
        return (y < x ? y : x);
    }
    
    number wrap(number x, number low, number high) {
        number lo;
        number hi;
    
        if (low == high)
            return low;
    
        if (low > high) {
            hi = low;
            lo = high;
        } else {
            lo = low;
            hi = high;
        }
    
        number range = hi - lo;
    
        if (x >= lo && x < hi)
            return x;
    
        if (range <= 0.000000001)
            return lo;
    
        Int numWraps = (Int)(trunc((x - lo) / range));
        numWraps = numWraps - ((x < lo ? 1 : 0));
        number result = x - range * numWraps;
    
        if (result >= hi)
            return result - range;
        else
            return result;
    }
    
    MillisecondTime getPatcherTime() const {
        return this->_currentTime;
    }
    
    void eventinlet_80_out1_bang_bang() {
        this->ip_73_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_80_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_73_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_73_value_set(converted);
        }
    }
    
    void eventinlet_81_out1_bang_bang() {
        this->ip_74_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_81_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_74_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_74_value_set(converted);
        }
    }
    
    void eventinlet_82_out1_bang_bang() {
        this->ip_75_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_82_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_75_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_75_value_set(converted);
        }
    }
    
    void eventinlet_83_out1_bang_bang() {
        this->ip_76_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_83_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_76_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_76_value_set(converted);
        }
    }
    
    void eventinlet_84_out1_bang_bang() {
        this->ip_77_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_84_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_77_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_77_value_set(converted);
        }
    }
    
    void eventinlet_85_out1_bang_bang() {
        this->ip_78_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_85_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_78_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_78_value_set(converted);
        }
    }
    
    void eventinlet_86_out1_bang_bang() {
        this->ip_79_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_86_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_79_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_79_value_set(converted);
        }
    }
    
    void eventinlet_87_out1_bang_bang() {
        this->ip_80_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_87_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_80_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_80_value_set(converted);
        }
    }
    
    void eventinlet_88_out1_bang_bang() {
        this->ip_81_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_88_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_81_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_81_value_set(converted);
        }
    }
    
    void eventinlet_89_out1_bang_bang() {
        this->ip_82_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_89_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_82_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_82_value_set(converted);
        }
    }
    
    void eventinlet_90_out1_bang_bang() {
        this->ip_83_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_90_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_83_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_83_value_set(converted);
        }
    }
    
    void eventinlet_91_out1_bang_bang() {
        this->ip_84_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_91_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_84_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_84_value_set(converted);
        }
    }
    
    void deallocateSignals() {
        Index i;
    
        for (i = 0; i < 14; i++) {
            this->signals[i] = freeSignal(this->signals[i]);
        }
    
        this->click_07_buf = freeSignal(this->click_07_buf);
        this->ip_73_sigbuf = freeSignal(this->ip_73_sigbuf);
        this->ip_74_sigbuf = freeSignal(this->ip_74_sigbuf);
        this->ip_75_sigbuf = freeSignal(this->ip_75_sigbuf);
        this->ip_76_sigbuf = freeSignal(this->ip_76_sigbuf);
        this->ip_77_sigbuf = freeSignal(this->ip_77_sigbuf);
        this->ip_78_sigbuf = freeSignal(this->ip_78_sigbuf);
        this->ip_79_sigbuf = freeSignal(this->ip_79_sigbuf);
        this->ip_80_sigbuf = freeSignal(this->ip_80_sigbuf);
        this->ip_81_sigbuf = freeSignal(this->ip_81_sigbuf);
        this->ip_82_sigbuf = freeSignal(this->ip_82_sigbuf);
        this->ip_83_sigbuf = freeSignal(this->ip_83_sigbuf);
        this->ip_84_sigbuf = freeSignal(this->ip_84_sigbuf);
        this->zeroBuffer = freeSignal(this->zeroBuffer);
        this->dummyBuffer = freeSignal(this->dummyBuffer);
    }
    
    Index getMaxBlockSize() const {
        return this->maxvs;
    }
    
    number getSampleRate() const {
        return this->sr;
    }
    
    bool hasFixedVectorSize() const {
        return false;
    }
    
    void setProbingTarget(MessageTag ) {}
    
    void initializeObjects() {
        this->ip_73_init();
        this->ip_74_init();
        this->ip_75_init();
        this->ip_76_init();
        this->ip_77_init();
        this->ip_78_init();
        this->ip_79_init();
        this->ip_80_init();
        this->ip_81_init();
        this->ip_82_init();
        this->ip_83_init();
        this->ip_84_init();
    }
    
    Index getIsMuted()  {
        return this->isMuted;
    }
    
    void setIsMuted(Index v)  {
        this->isMuted = v;
    }
    
    void onSampleRateChanged(double ) {}
    
    void extractState(PatcherStateInterface& ) {}
    
    void applyState() {}
    
    void setParameterOffset(ParameterIndex offset) {
        this->parameterOffset = offset;
    }
    
    void processClockEvent(MillisecondTime , ClockId , bool , ParameterValue ) {}
    
    void processOutletAtCurrentTime(EngineLink* , OutletIndex , ParameterValue ) {}
    
    void processOutletEvent(
        EngineLink* sender,
        OutletIndex index,
        ParameterValue value,
        MillisecondTime time
    ) {
        this->updateTime(time, (ENGINE*)nullptr);
        this->processOutletAtCurrentTime(sender, index, value);
    }
    
    void sendOutlet(OutletIndex index, ParameterValue value) {
        this->getEngine()->sendOutlet(this, index, value);
    }
    
    void startup() {}
    
    void fillDataRef(DataRefIndex , DataRef& ) {}
    
    void allocateDataRefs() {}
    
    void ip_73_value_set(number v) {
        this->ip_73_value = v;
        this->ip_73_fillSigBuf();
        this->ip_73_lastValue = v;
    }
    
    void eventinlet_80_out1_number_set(number v) {
        this->ip_73_value_set(v);
    }
    
    void ip_76_value_set(number v) {
        this->ip_76_value = v;
        this->ip_76_fillSigBuf();
        this->ip_76_lastValue = v;
    }
    
    void eventinlet_83_out1_number_set(number v) {
        this->ip_76_value_set(v);
    }
    
    void ip_77_value_set(number v) {
        this->ip_77_value = v;
        this->ip_77_fillSigBuf();
        this->ip_77_lastValue = v;
    }
    
    void eventinlet_84_out1_number_set(number v) {
        this->ip_77_value_set(v);
    }
    
    void ip_74_value_set(number v) {
        this->ip_74_value = v;
        this->ip_74_fillSigBuf();
        this->ip_74_lastValue = v;
    }
    
    void eventinlet_81_out1_number_set(number v) {
        this->ip_74_value_set(v);
    }
    
    void ip_75_value_set(number v) {
        this->ip_75_value = v;
        this->ip_75_fillSigBuf();
        this->ip_75_lastValue = v;
    }
    
    void eventinlet_82_out1_number_set(number v) {
        this->ip_75_value_set(v);
    }
    
    void ip_78_value_set(number v) {
        this->ip_78_value = v;
        this->ip_78_fillSigBuf();
        this->ip_78_lastValue = v;
    }
    
    void eventinlet_85_out1_number_set(number v) {
        this->ip_78_value_set(v);
    }
    
    void ip_81_value_set(number v) {
        this->ip_81_value = v;
        this->ip_81_fillSigBuf();
        this->ip_81_lastValue = v;
    }
    
    void eventinlet_88_out1_number_set(number v) {
        this->ip_81_value_set(v);
    }
    
    void ip_82_value_set(number v) {
        this->ip_82_value = v;
        this->ip_82_fillSigBuf();
        this->ip_82_lastValue = v;
    }
    
    void eventinlet_89_out1_number_set(number v) {
        this->ip_82_value_set(v);
    }
    
    void ip_83_value_set(number v) {
        this->ip_83_value = v;
        this->ip_83_fillSigBuf();
        this->ip_83_lastValue = v;
    }
    
    void eventinlet_90_out1_number_set(number v) {
        this->ip_83_value_set(v);
    }
    
    void ip_79_value_set(number v) {
        this->ip_79_value = v;
        this->ip_79_fillSigBuf();
        this->ip_79_lastValue = v;
    }
    
    void eventinlet_86_out1_number_set(number v) {
        this->ip_79_value_set(v);
    }
    
    void ip_80_value_set(number v) {
        this->ip_80_value = v;
        this->ip_80_fillSigBuf();
        this->ip_80_lastValue = v;
    }
    
    void eventinlet_87_out1_number_set(number v) {
        this->ip_80_value_set(v);
    }
    
    void ip_84_value_set(number v) {
        this->ip_84_value = v;
        this->ip_84_fillSigBuf();
        this->ip_84_lastValue = v;
    }
    
    void eventinlet_91_out1_number_set(number v) {
        this->ip_84_value_set(v);
    }
    
    void click_07_click_number_set(number v) {
        for (SampleIndex i = (SampleIndex)(this->click_07_lastclick + 1); i < this->sampleOffsetIntoNextAudioBuffer; i++) {
            this->click_07_buf[(Index)i] = 0;
        }
    
        this->click_07_lastclick = this->sampleOffsetIntoNextAudioBuffer;
        this->click_07_buf[(Index)this->click_07_lastclick] = v;
    }
    
    void click_07_click_bang_bang() {
        this->click_07_click_number_set(1);
    }
    
    void eventinlet_79_out1_bang_bang() {
        this->click_07_click_bang_bang();
    }
    
    void eventinlet_79_out1_number_set(number v) {
        this->click_07_click_number_set(v);
    }
    
    template<typename LISTTYPE> void eventinlet_79_out1_list_set(const LISTTYPE& v) {
        {
            number converted = (v->length > 0 ? v[0] : 0);
            this->click_07_click_number_set(converted);
        }
    }
    
    void ip_73_value_bang() {
        number v = this->ip_73_value;
        this->ip_73_fillSigBuf();
        this->ip_73_lastValue = v;
    }
    
    void ip_73_impulse_set(number v) {
        this->ip_73_impulse = v;
        this->ip_73_fillSigBuf();
        this->ip_73_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_73_resetCount = lengthInSamples;
    }
    
    void ip_74_value_bang() {
        number v = this->ip_74_value;
        this->ip_74_fillSigBuf();
        this->ip_74_lastValue = v;
    }
    
    void ip_74_impulse_set(number v) {
        this->ip_74_impulse = v;
        this->ip_74_fillSigBuf();
        this->ip_74_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_74_resetCount = lengthInSamples;
    }
    
    void ip_75_value_bang() {
        number v = this->ip_75_value;
        this->ip_75_fillSigBuf();
        this->ip_75_lastValue = v;
    }
    
    void ip_75_impulse_set(number v) {
        this->ip_75_impulse = v;
        this->ip_75_fillSigBuf();
        this->ip_75_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_75_resetCount = lengthInSamples;
    }
    
    void ip_76_value_bang() {
        number v = this->ip_76_value;
        this->ip_76_fillSigBuf();
        this->ip_76_lastValue = v;
    }
    
    void ip_76_impulse_set(number v) {
        this->ip_76_impulse = v;
        this->ip_76_fillSigBuf();
        this->ip_76_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_76_resetCount = lengthInSamples;
    }
    
    void ip_77_value_bang() {
        number v = this->ip_77_value;
        this->ip_77_fillSigBuf();
        this->ip_77_lastValue = v;
    }
    
    void ip_77_impulse_set(number v) {
        this->ip_77_impulse = v;
        this->ip_77_fillSigBuf();
        this->ip_77_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_77_resetCount = lengthInSamples;
    }
    
    void ip_78_value_bang() {
        number v = this->ip_78_value;
        this->ip_78_fillSigBuf();
        this->ip_78_lastValue = v;
    }
    
    void ip_78_impulse_set(number v) {
        this->ip_78_impulse = v;
        this->ip_78_fillSigBuf();
        this->ip_78_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_78_resetCount = lengthInSamples;
    }
    
    void ip_79_value_bang() {
        number v = this->ip_79_value;
        this->ip_79_fillSigBuf();
        this->ip_79_lastValue = v;
    }
    
    void ip_79_impulse_set(number v) {
        this->ip_79_impulse = v;
        this->ip_79_fillSigBuf();
        this->ip_79_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_79_resetCount = lengthInSamples;
    }
    
    void ip_80_value_bang() {
        number v = this->ip_80_value;
        this->ip_80_fillSigBuf();
        this->ip_80_lastValue = v;
    }
    
    void ip_80_impulse_set(number v) {
        this->ip_80_impulse = v;
        this->ip_80_fillSigBuf();
        this->ip_80_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_80_resetCount = lengthInSamples;
    }
    
    void ip_81_value_bang() {
        number v = this->ip_81_value;
        this->ip_81_fillSigBuf();
        this->ip_81_lastValue = v;
    }
    
    void ip_81_impulse_set(number v) {
        this->ip_81_impulse = v;
        this->ip_81_fillSigBuf();
        this->ip_81_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_81_resetCount = lengthInSamples;
    }
    
    void ip_82_value_bang() {
        number v = this->ip_82_value;
        this->ip_82_fillSigBuf();
        this->ip_82_lastValue = v;
    }
    
    void ip_82_impulse_set(number v) {
        this->ip_82_impulse = v;
        this->ip_82_fillSigBuf();
        this->ip_82_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_82_resetCount = lengthInSamples;
    }
    
    void ip_83_value_bang() {
        number v = this->ip_83_value;
        this->ip_83_fillSigBuf();
        this->ip_83_lastValue = v;
    }
    
    void ip_83_impulse_set(number v) {
        this->ip_83_impulse = v;
        this->ip_83_fillSigBuf();
        this->ip_83_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_83_resetCount = lengthInSamples;
    }
    
    void ip_84_value_bang() {
        number v = this->ip_84_value;
        this->ip_84_fillSigBuf();
        this->ip_84_lastValue = v;
    }
    
    void ip_84_impulse_set(number v) {
        this->ip_84_impulse = v;
        this->ip_84_fillSigBuf();
        this->ip_84_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_84_resetCount = lengthInSamples;
    }
    
    void click_07_perform(SampleValue * out, Index n) {
        auto __click_07_lastclick = this->click_07_lastclick;
    
        for (SampleIndex i = 0; i <= __click_07_lastclick; i++) {
            out[(Index)i] = this->click_07_buf[(Index)i];
        }
    
        for (SampleIndex i = (SampleIndex)(__click_07_lastclick + 1); i < (SampleIndex)(n); i++) {
            out[(Index)i] = 0;
        }
    
        __click_07_lastclick = -1;
        this->click_07_lastclick = __click_07_lastclick;
    }
    
    void ip_73_perform(SampleValue * out, Index n) {
        auto __ip_73_lastValue = this->ip_73_lastValue;
        auto __ip_73_lastIndex = this->ip_73_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_73_lastIndex ? __ip_73_lastValue : this->ip_73_sigbuf[(Index)i]);
        }
    
        __ip_73_lastIndex = 0;
        this->ip_73_lastIndex = __ip_73_lastIndex;
    }
    
    void ip_74_perform(SampleValue * out, Index n) {
        auto __ip_74_lastValue = this->ip_74_lastValue;
        auto __ip_74_lastIndex = this->ip_74_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_74_lastIndex ? __ip_74_lastValue : this->ip_74_sigbuf[(Index)i]);
        }
    
        __ip_74_lastIndex = 0;
        this->ip_74_lastIndex = __ip_74_lastIndex;
    }
    
    void ip_75_perform(SampleValue * out, Index n) {
        auto __ip_75_lastValue = this->ip_75_lastValue;
        auto __ip_75_lastIndex = this->ip_75_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_75_lastIndex ? __ip_75_lastValue : this->ip_75_sigbuf[(Index)i]);
        }
    
        __ip_75_lastIndex = 0;
        this->ip_75_lastIndex = __ip_75_lastIndex;
    }
    
    void ip_76_perform(SampleValue * out, Index n) {
        auto __ip_76_lastValue = this->ip_76_lastValue;
        auto __ip_76_lastIndex = this->ip_76_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_76_lastIndex ? __ip_76_lastValue : this->ip_76_sigbuf[(Index)i]);
        }
    
        __ip_76_lastIndex = 0;
        this->ip_76_lastIndex = __ip_76_lastIndex;
    }
    
    void ip_77_perform(SampleValue * out, Index n) {
        auto __ip_77_lastValue = this->ip_77_lastValue;
        auto __ip_77_lastIndex = this->ip_77_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_77_lastIndex ? __ip_77_lastValue : this->ip_77_sigbuf[(Index)i]);
        }
    
        __ip_77_lastIndex = 0;
        this->ip_77_lastIndex = __ip_77_lastIndex;
    }
    
    void ip_78_perform(SampleValue * out, Index n) {
        auto __ip_78_lastValue = this->ip_78_lastValue;
        auto __ip_78_lastIndex = this->ip_78_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_78_lastIndex ? __ip_78_lastValue : this->ip_78_sigbuf[(Index)i]);
        }
    
        __ip_78_lastIndex = 0;
        this->ip_78_lastIndex = __ip_78_lastIndex;
    }
    
    void ip_79_perform(SampleValue * out, Index n) {
        auto __ip_79_lastValue = this->ip_79_lastValue;
        auto __ip_79_lastIndex = this->ip_79_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_79_lastIndex ? __ip_79_lastValue : this->ip_79_sigbuf[(Index)i]);
        }
    
        __ip_79_lastIndex = 0;
        this->ip_79_lastIndex = __ip_79_lastIndex;
    }
    
    void ip_80_perform(SampleValue * out, Index n) {
        auto __ip_80_lastValue = this->ip_80_lastValue;
        auto __ip_80_lastIndex = this->ip_80_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_80_lastIndex ? __ip_80_lastValue : this->ip_80_sigbuf[(Index)i]);
        }
    
        __ip_80_lastIndex = 0;
        this->ip_80_lastIndex = __ip_80_lastIndex;
    }
    
    void ip_81_perform(SampleValue * out, Index n) {
        auto __ip_81_lastValue = this->ip_81_lastValue;
        auto __ip_81_lastIndex = this->ip_81_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_81_lastIndex ? __ip_81_lastValue : this->ip_81_sigbuf[(Index)i]);
        }
    
        __ip_81_lastIndex = 0;
        this->ip_81_lastIndex = __ip_81_lastIndex;
    }
    
    void ip_82_perform(SampleValue * out, Index n) {
        auto __ip_82_lastValue = this->ip_82_lastValue;
        auto __ip_82_lastIndex = this->ip_82_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_82_lastIndex ? __ip_82_lastValue : this->ip_82_sigbuf[(Index)i]);
        }
    
        __ip_82_lastIndex = 0;
        this->ip_82_lastIndex = __ip_82_lastIndex;
    }
    
    void ip_83_perform(SampleValue * out, Index n) {
        auto __ip_83_lastValue = this->ip_83_lastValue;
        auto __ip_83_lastIndex = this->ip_83_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_83_lastIndex ? __ip_83_lastValue : this->ip_83_sigbuf[(Index)i]);
        }
    
        __ip_83_lastIndex = 0;
        this->ip_83_lastIndex = __ip_83_lastIndex;
    }
    
    void ip_84_perform(SampleValue * out, Index n) {
        auto __ip_84_lastValue = this->ip_84_lastValue;
        auto __ip_84_lastIndex = this->ip_84_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_84_lastIndex ? __ip_84_lastValue : this->ip_84_sigbuf[(Index)i]);
        }
    
        __ip_84_lastIndex = 0;
        this->ip_84_lastIndex = __ip_84_lastIndex;
    }
    
    void codebox_tilde_07_perform(
        const Sample * in1,
        const Sample * in2,
        const Sample * in3,
        const Sample * in4,
        const Sample * in5,
        const Sample * in6,
        const Sample * in7,
        const Sample * in8,
        const Sample * in9,
        const Sample * in10,
        const Sample * in11,
        const Sample * in12,
        const Sample * in13,
        SampleValue * out1,
        Index n
    ) {
        auto __codebox_tilde_07_noiseState = this->codebox_tilde_07_noiseState;
        auto __codebox_tilde_07_lowCoef = this->codebox_tilde_07_lowCoef;
        auto __codebox_tilde_07_strikeCoef = this->codebox_tilde_07_strikeCoef;
        auto __codebox_tilde_07_modeCoef = this->codebox_tilde_07_modeCoef;
        auto __codebox_tilde_07_fmCoef = this->codebox_tilde_07_fmCoef;
        auto __codebox_tilde_07_envCoef = this->codebox_tilde_07_envCoef;
        auto __codebox_tilde_07_low = this->codebox_tilde_07_low;
        auto __codebox_tilde_07_mode2 = this->codebox_tilde_07_mode2;
        auto __codebox_tilde_07_mode1 = this->codebox_tilde_07_mode1;
        auto __codebox_tilde_07_modPhase = this->codebox_tilde_07_modPhase;
        auto __codebox_tilde_07_phase = this->codebox_tilde_07_phase;
        auto __codebox_tilde_07_strikeEnv = this->codebox_tilde_07_strikeEnv;
        auto __codebox_tilde_07_modeEnv = this->codebox_tilde_07_modeEnv;
        auto __codebox_tilde_07_fmEnv = this->codebox_tilde_07_fmEnv;
        auto __codebox_tilde_07_env = this->codebox_tilde_07_env;
        auto __codebox_tilde_07_active = this->codebox_tilde_07_active;
        auto __codebox_tilde_07_hitLevel = this->codebox_tilde_07_hitLevel;
        auto __codebox_tilde_07_hitDrive = this->codebox_tilde_07_hitDrive;
        auto __codebox_tilde_07_hitBrightness = this->codebox_tilde_07_hitBrightness;
        auto __codebox_tilde_07_hitStrike = this->codebox_tilde_07_hitStrike;
        auto __codebox_tilde_07_hitModeDecayMs = this->codebox_tilde_07_hitModeDecayMs;
        auto __codebox_tilde_07_hitModeLevel = this->codebox_tilde_07_hitModeLevel;
        auto __codebox_tilde_07_hitInharmonicity = this->codebox_tilde_07_hitInharmonicity;
        auto __codebox_tilde_07_hitFmDecayMs = this->codebox_tilde_07_hitFmDecayMs;
        auto __codebox_tilde_07_hitFmIndex = this->codebox_tilde_07_hitFmIndex;
        auto __codebox_tilde_07_hitFmRatio = this->codebox_tilde_07_hitFmRatio;
        auto __codebox_tilde_07_hitDecayMs = this->codebox_tilde_07_hitDecayMs;
        auto __codebox_tilde_07_hitPitchHz = this->codebox_tilde_07_hitPitchHz;
        Index i;
    
        for (i = 0; i < (Index)n; i++) {
            number trig = in1[(Index)i];
            number sr = this->sr;
    
            if (trig > 0) {
                __codebox_tilde_07_hitPitchHz = in2[(Index)i];//#map:_###_obj_###_:33
                __codebox_tilde_07_hitDecayMs = in3[(Index)i];//#map:_###_obj_###_:34
                __codebox_tilde_07_hitFmRatio = in4[(Index)i];//#map:_###_obj_###_:35
                __codebox_tilde_07_hitFmIndex = in5[(Index)i];//#map:_###_obj_###_:36
                __codebox_tilde_07_hitFmDecayMs = in6[(Index)i];//#map:_###_obj_###_:37
                __codebox_tilde_07_hitInharmonicity = in7[(Index)i];//#map:_###_obj_###_:38
                __codebox_tilde_07_hitModeLevel = in8[(Index)i];//#map:_###_obj_###_:39
                __codebox_tilde_07_hitModeDecayMs = in9[(Index)i];//#map:_###_obj_###_:40
                __codebox_tilde_07_hitStrike = in10[(Index)i];//#map:_###_obj_###_:41
                __codebox_tilde_07_hitBrightness = in11[(Index)i];//#map:_###_obj_###_:42
                __codebox_tilde_07_hitDrive = in12[(Index)i];//#map:_###_obj_###_:43
                __codebox_tilde_07_hitLevel = in13[(Index)i];//#map:_###_obj_###_:44
            }//#map:_###_obj_###_:32
    
            if (trig > 0) {
                __codebox_tilde_07_active = 1;//#map:_###_obj_###_:47
                __codebox_tilde_07_env = 1;//#map:_###_obj_###_:48
                __codebox_tilde_07_fmEnv = 1;//#map:_###_obj_###_:48
                __codebox_tilde_07_modeEnv = 1;//#map:_###_obj_###_:48
                __codebox_tilde_07_strikeEnv = 1;//#map:_###_obj_###_:48
                __codebox_tilde_07_phase = 0;//#map:_###_obj_###_:49
                __codebox_tilde_07_modPhase = 0;//#map:_###_obj_###_:49
                __codebox_tilde_07_mode1 = 0;//#map:_###_obj_###_:49
                __codebox_tilde_07_mode2 = 0;//#map:_###_obj_###_:49
                __codebox_tilde_07_low = 0;//#map:_###_obj_###_:49
    
                __codebox_tilde_07_envCoef = rnbo_exp(
                    (this->maximum(20, __codebox_tilde_07_hitDecayMs) * 0.001 * sr == 0. ? 0. : -6.907755 / (this->maximum(20, __codebox_tilde_07_hitDecayMs) * 0.001 * sr))
                );//#map:_###_obj_###_:50
    
                __codebox_tilde_07_fmCoef = rnbo_exp(
                    (this->maximum(5, __codebox_tilde_07_hitFmDecayMs) * 0.001 * sr == 0. ? 0. : -6.907755 / (this->maximum(5, __codebox_tilde_07_hitFmDecayMs) * 0.001 * sr))
                );//#map:_###_obj_###_:51
    
                __codebox_tilde_07_modeCoef = rnbo_exp(
                    (this->maximum(10, __codebox_tilde_07_hitModeDecayMs) * 0.001 * sr == 0. ? 0. : -6.907755 / (this->maximum(10, __codebox_tilde_07_hitModeDecayMs) * 0.001 * sr))
                );//#map:_###_obj_###_:52
    
                __codebox_tilde_07_strikeCoef = rnbo_exp((0.006 * sr == 0. ? 0. : -6.907755 / (0.006 * sr)));//#map:_###_obj_###_:53
    
                __codebox_tilde_07_lowCoef = rnbo_exp((sr == 0. ? 0. : -6.283185307179586 * this->minimum(
                    500 + 17500 * __codebox_tilde_07_hitBrightness * __codebox_tilde_07_hitBrightness,
                    sr * 0.45
                ) / sr));//#map:_###_obj_###_:54
            }//#map:_###_obj_###_:46
    
            out1[(Index)i] = 0;//#map:_###_obj_###_:56
    
            if (__codebox_tilde_07_active > 0) {
                __codebox_tilde_07_env *= __codebox_tilde_07_envCoef;//#map:_###_obj_###_:58
                __codebox_tilde_07_fmEnv *= __codebox_tilde_07_fmCoef;//#map:_###_obj_###_:58
                __codebox_tilde_07_modeEnv *= __codebox_tilde_07_modeCoef;//#map:_###_obj_###_:58
                __codebox_tilde_07_strikeEnv *= __codebox_tilde_07_strikeCoef;//#map:_###_obj_###_:58
                number hz = (__codebox_tilde_07_hitPitchHz > sr * 0.18 ? sr * 0.18 : (__codebox_tilde_07_hitPitchHz < 40 ? 40 : __codebox_tilde_07_hitPitchHz));
                __codebox_tilde_07_phase = this->wrap(__codebox_tilde_07_phase + ((sr == 0. ? 0. : hz / sr)), 0, 1);//#map:_###_obj_###_:60
    
                __codebox_tilde_07_modPhase = this->wrap(
                    __codebox_tilde_07_modPhase + ((sr == 0. ? 0. : this->minimum(hz * __codebox_tilde_07_hitFmRatio, sr * 0.45) / sr)),
                    0,
                    1
                );//#map:_###_obj_###_:61
    
                __codebox_tilde_07_mode1 = this->wrap(
                    __codebox_tilde_07_mode1 + ((sr == 0. ? 0. : this->minimum(hz * (2 + __codebox_tilde_07_hitInharmonicity * 0.756), sr * 0.45) / sr)),
                    0,
                    1
                );//#map:_###_obj_###_:62
    
                __codebox_tilde_07_mode2 = this->wrap(
                    __codebox_tilde_07_mode2 + ((sr == 0. ? 0. : this->minimum(hz * (4 + __codebox_tilde_07_hitInharmonicity * 1.404), sr * 0.45) / sr)),
                    0,
                    1
                );//#map:_###_obj_###_:63
    
                number bell = rnbo_sin(
                    __codebox_tilde_07_phase * 6.283185307179586 + rnbo_sin(__codebox_tilde_07_modPhase * 6.283185307179586) * __codebox_tilde_07_hitFmIndex * __codebox_tilde_07_fmEnv
                );
    
                number modes = rnbo_sin(__codebox_tilde_07_mode1 * 6.283185307179586) + rnbo_sin(__codebox_tilde_07_mode2 * 6.283185307179586) * 0.55;
                __codebox_tilde_07_noiseState = this->wrap((__codebox_tilde_07_noiseState + 1) * 16807, 0, 2147483647) - 1;//#map:_###_obj_###_:66
                number white = (__codebox_tilde_07_noiseState + 1) / (number)1073741823.5 - 1;
                number source = bell * __codebox_tilde_07_env * 0.7 + modes * __codebox_tilde_07_modeEnv * __codebox_tilde_07_hitModeLevel * 0.4 + white * __codebox_tilde_07_strikeEnv * __codebox_tilde_07_hitStrike * 0.5;
                __codebox_tilde_07_low = source * (1 - __codebox_tilde_07_lowCoef) + __codebox_tilde_07_low * __codebox_tilde_07_lowCoef;//#map:_###_obj_###_:69
                number raw = __codebox_tilde_07_low;
                auto drive = this->maximum(0.25, __codebox_tilde_07_hitDrive);
                out1[(Index)i] = ((rnbo_tanh(drive) == 0. ? 0. : rnbo_tanh(raw * drive) / rnbo_tanh(drive))) * ((__codebox_tilde_07_hitLevel > 1 ? 1 : (__codebox_tilde_07_hitLevel < 0 ? 0 : __codebox_tilde_07_hitLevel)));//#map:_###_obj_###_:72
    
                if (__codebox_tilde_07_env < 1e-7 && __codebox_tilde_07_modeEnv < 1e-7 && rnbo_abs(__codebox_tilde_07_low) < 1e-7)
                    __codebox_tilde_07_active = 0;//#map:_###_obj_###_:73;//#map:_###_obj_###_:73
            }//#map:_###_obj_###_:57
        }
    
        this->codebox_tilde_07_hitPitchHz = __codebox_tilde_07_hitPitchHz;
        this->codebox_tilde_07_hitDecayMs = __codebox_tilde_07_hitDecayMs;
        this->codebox_tilde_07_hitFmRatio = __codebox_tilde_07_hitFmRatio;
        this->codebox_tilde_07_hitFmIndex = __codebox_tilde_07_hitFmIndex;
        this->codebox_tilde_07_hitFmDecayMs = __codebox_tilde_07_hitFmDecayMs;
        this->codebox_tilde_07_hitInharmonicity = __codebox_tilde_07_hitInharmonicity;
        this->codebox_tilde_07_hitModeLevel = __codebox_tilde_07_hitModeLevel;
        this->codebox_tilde_07_hitModeDecayMs = __codebox_tilde_07_hitModeDecayMs;
        this->codebox_tilde_07_hitStrike = __codebox_tilde_07_hitStrike;
        this->codebox_tilde_07_hitBrightness = __codebox_tilde_07_hitBrightness;
        this->codebox_tilde_07_hitDrive = __codebox_tilde_07_hitDrive;
        this->codebox_tilde_07_hitLevel = __codebox_tilde_07_hitLevel;
        this->codebox_tilde_07_active = __codebox_tilde_07_active;
        this->codebox_tilde_07_env = __codebox_tilde_07_env;
        this->codebox_tilde_07_fmEnv = __codebox_tilde_07_fmEnv;
        this->codebox_tilde_07_modeEnv = __codebox_tilde_07_modeEnv;
        this->codebox_tilde_07_strikeEnv = __codebox_tilde_07_strikeEnv;
        this->codebox_tilde_07_phase = __codebox_tilde_07_phase;
        this->codebox_tilde_07_modPhase = __codebox_tilde_07_modPhase;
        this->codebox_tilde_07_mode1 = __codebox_tilde_07_mode1;
        this->codebox_tilde_07_mode2 = __codebox_tilde_07_mode2;
        this->codebox_tilde_07_low = __codebox_tilde_07_low;
        this->codebox_tilde_07_envCoef = __codebox_tilde_07_envCoef;
        this->codebox_tilde_07_fmCoef = __codebox_tilde_07_fmCoef;
        this->codebox_tilde_07_modeCoef = __codebox_tilde_07_modeCoef;
        this->codebox_tilde_07_strikeCoef = __codebox_tilde_07_strikeCoef;
        this->codebox_tilde_07_lowCoef = __codebox_tilde_07_lowCoef;
        this->codebox_tilde_07_noiseState = __codebox_tilde_07_noiseState;
    }
    
    void dspexpr_07_perform(const Sample * in1, number in2, SampleValue * out1, Index n) {
        RNBO_UNUSED(in2);
        Index i;
    
        for (i = 0; i < (Index)n; i++) {
            out1[(Index)i] = in1[(Index)i] * 1;//#map:_###_obj_###_:1
        }
    }
    
    void signalforwarder_13_perform(const SampleValue * input, SampleValue * output, Index n) {
        copySignal(output, input, n);
    }
    
    void signalforwarder_14_perform(const SampleValue * input, SampleValue * output, Index n) {
        copySignal(output, input, n);
    }
    
    void stackprotect_perform(Index n) {
        RNBO_UNUSED(n);
        auto __stackprotect_count = this->stackprotect_count;
        __stackprotect_count = 0;
        this->stackprotect_count = __stackprotect_count;
    }
    
    void ip_73_init() {
        this->ip_73_lastValue = this->ip_73_value;
    }
    
    void ip_73_fillSigBuf() {
        if ((bool)(this->ip_73_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_73_lastIndex); i < k; i++) {
                if (this->ip_73_resetCount > 0) {
                    this->ip_73_sigbuf[(Index)i] = 1;
                    this->ip_73_resetCount--;
                } else {
                    this->ip_73_sigbuf[(Index)i] = this->ip_73_lastValue;
                }
            }
    
            this->ip_73_lastIndex = k;
        }
    }
    
    void ip_73_dspsetup(bool force) {
        if ((bool)(this->ip_73_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_73_lastIndex = 0;
        this->ip_73_setupDone = true;
    }
    
    void ip_74_init() {
        this->ip_74_lastValue = this->ip_74_value;
    }
    
    void ip_74_fillSigBuf() {
        if ((bool)(this->ip_74_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_74_lastIndex); i < k; i++) {
                if (this->ip_74_resetCount > 0) {
                    this->ip_74_sigbuf[(Index)i] = 1;
                    this->ip_74_resetCount--;
                } else {
                    this->ip_74_sigbuf[(Index)i] = this->ip_74_lastValue;
                }
            }
    
            this->ip_74_lastIndex = k;
        }
    }
    
    void ip_74_dspsetup(bool force) {
        if ((bool)(this->ip_74_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_74_lastIndex = 0;
        this->ip_74_setupDone = true;
    }
    
    void ip_75_init() {
        this->ip_75_lastValue = this->ip_75_value;
    }
    
    void ip_75_fillSigBuf() {
        if ((bool)(this->ip_75_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_75_lastIndex); i < k; i++) {
                if (this->ip_75_resetCount > 0) {
                    this->ip_75_sigbuf[(Index)i] = 1;
                    this->ip_75_resetCount--;
                } else {
                    this->ip_75_sigbuf[(Index)i] = this->ip_75_lastValue;
                }
            }
    
            this->ip_75_lastIndex = k;
        }
    }
    
    void ip_75_dspsetup(bool force) {
        if ((bool)(this->ip_75_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_75_lastIndex = 0;
        this->ip_75_setupDone = true;
    }
    
    void ip_76_init() {
        this->ip_76_lastValue = this->ip_76_value;
    }
    
    void ip_76_fillSigBuf() {
        if ((bool)(this->ip_76_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_76_lastIndex); i < k; i++) {
                if (this->ip_76_resetCount > 0) {
                    this->ip_76_sigbuf[(Index)i] = 1;
                    this->ip_76_resetCount--;
                } else {
                    this->ip_76_sigbuf[(Index)i] = this->ip_76_lastValue;
                }
            }
    
            this->ip_76_lastIndex = k;
        }
    }
    
    void ip_76_dspsetup(bool force) {
        if ((bool)(this->ip_76_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_76_lastIndex = 0;
        this->ip_76_setupDone = true;
    }
    
    void ip_77_init() {
        this->ip_77_lastValue = this->ip_77_value;
    }
    
    void ip_77_fillSigBuf() {
        if ((bool)(this->ip_77_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_77_lastIndex); i < k; i++) {
                if (this->ip_77_resetCount > 0) {
                    this->ip_77_sigbuf[(Index)i] = 1;
                    this->ip_77_resetCount--;
                } else {
                    this->ip_77_sigbuf[(Index)i] = this->ip_77_lastValue;
                }
            }
    
            this->ip_77_lastIndex = k;
        }
    }
    
    void ip_77_dspsetup(bool force) {
        if ((bool)(this->ip_77_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_77_lastIndex = 0;
        this->ip_77_setupDone = true;
    }
    
    void ip_78_init() {
        this->ip_78_lastValue = this->ip_78_value;
    }
    
    void ip_78_fillSigBuf() {
        if ((bool)(this->ip_78_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_78_lastIndex); i < k; i++) {
                if (this->ip_78_resetCount > 0) {
                    this->ip_78_sigbuf[(Index)i] = 1;
                    this->ip_78_resetCount--;
                } else {
                    this->ip_78_sigbuf[(Index)i] = this->ip_78_lastValue;
                }
            }
    
            this->ip_78_lastIndex = k;
        }
    }
    
    void ip_78_dspsetup(bool force) {
        if ((bool)(this->ip_78_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_78_lastIndex = 0;
        this->ip_78_setupDone = true;
    }
    
    void ip_79_init() {
        this->ip_79_lastValue = this->ip_79_value;
    }
    
    void ip_79_fillSigBuf() {
        if ((bool)(this->ip_79_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_79_lastIndex); i < k; i++) {
                if (this->ip_79_resetCount > 0) {
                    this->ip_79_sigbuf[(Index)i] = 1;
                    this->ip_79_resetCount--;
                } else {
                    this->ip_79_sigbuf[(Index)i] = this->ip_79_lastValue;
                }
            }
    
            this->ip_79_lastIndex = k;
        }
    }
    
    void ip_79_dspsetup(bool force) {
        if ((bool)(this->ip_79_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_79_lastIndex = 0;
        this->ip_79_setupDone = true;
    }
    
    void ip_80_init() {
        this->ip_80_lastValue = this->ip_80_value;
    }
    
    void ip_80_fillSigBuf() {
        if ((bool)(this->ip_80_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_80_lastIndex); i < k; i++) {
                if (this->ip_80_resetCount > 0) {
                    this->ip_80_sigbuf[(Index)i] = 1;
                    this->ip_80_resetCount--;
                } else {
                    this->ip_80_sigbuf[(Index)i] = this->ip_80_lastValue;
                }
            }
    
            this->ip_80_lastIndex = k;
        }
    }
    
    void ip_80_dspsetup(bool force) {
        if ((bool)(this->ip_80_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_80_lastIndex = 0;
        this->ip_80_setupDone = true;
    }
    
    void ip_81_init() {
        this->ip_81_lastValue = this->ip_81_value;
    }
    
    void ip_81_fillSigBuf() {
        if ((bool)(this->ip_81_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_81_lastIndex); i < k; i++) {
                if (this->ip_81_resetCount > 0) {
                    this->ip_81_sigbuf[(Index)i] = 1;
                    this->ip_81_resetCount--;
                } else {
                    this->ip_81_sigbuf[(Index)i] = this->ip_81_lastValue;
                }
            }
    
            this->ip_81_lastIndex = k;
        }
    }
    
    void ip_81_dspsetup(bool force) {
        if ((bool)(this->ip_81_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_81_lastIndex = 0;
        this->ip_81_setupDone = true;
    }
    
    void ip_82_init() {
        this->ip_82_lastValue = this->ip_82_value;
    }
    
    void ip_82_fillSigBuf() {
        if ((bool)(this->ip_82_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_82_lastIndex); i < k; i++) {
                if (this->ip_82_resetCount > 0) {
                    this->ip_82_sigbuf[(Index)i] = 1;
                    this->ip_82_resetCount--;
                } else {
                    this->ip_82_sigbuf[(Index)i] = this->ip_82_lastValue;
                }
            }
    
            this->ip_82_lastIndex = k;
        }
    }
    
    void ip_82_dspsetup(bool force) {
        if ((bool)(this->ip_82_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_82_lastIndex = 0;
        this->ip_82_setupDone = true;
    }
    
    void ip_83_init() {
        this->ip_83_lastValue = this->ip_83_value;
    }
    
    void ip_83_fillSigBuf() {
        if ((bool)(this->ip_83_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_83_lastIndex); i < k; i++) {
                if (this->ip_83_resetCount > 0) {
                    this->ip_83_sigbuf[(Index)i] = 1;
                    this->ip_83_resetCount--;
                } else {
                    this->ip_83_sigbuf[(Index)i] = this->ip_83_lastValue;
                }
            }
    
            this->ip_83_lastIndex = k;
        }
    }
    
    void ip_83_dspsetup(bool force) {
        if ((bool)(this->ip_83_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_83_lastIndex = 0;
        this->ip_83_setupDone = true;
    }
    
    void ip_84_init() {
        this->ip_84_lastValue = this->ip_84_value;
    }
    
    void ip_84_fillSigBuf() {
        if ((bool)(this->ip_84_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_84_lastIndex); i < k; i++) {
                if (this->ip_84_resetCount > 0) {
                    this->ip_84_sigbuf[(Index)i] = 1;
                    this->ip_84_resetCount--;
                } else {
                    this->ip_84_sigbuf[(Index)i] = this->ip_84_lastValue;
                }
            }
    
            this->ip_84_lastIndex = k;
        }
    }
    
    void ip_84_dspsetup(bool force) {
        if ((bool)(this->ip_84_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_84_lastIndex = 0;
        this->ip_84_setupDone = true;
    }
    
    bool stackprotect_check() {
        this->stackprotect_count++;
    
        if (this->stackprotect_count > 128) {
            console->log("STACK OVERFLOW DETECTED - stopped processing branch !");
            return true;
        }
    
        return false;
    }
    
    Index getPatcherSerial() const {
        return 0;
    }
    
    void sendParameter(ParameterIndex index, bool ignoreValue) {
        this->getPatcher()->sendParameter(index + this->parameterOffset, ignoreValue);
    }
    
    void scheduleParamInit(ParameterIndex index, Index order) {
        this->getPatcher()->scheduleParamInit(index + this->parameterOffset, order);
    }
    
    void updateTime(MillisecondTime time, EXTERNALENGINE* engine, bool inProcess = false) {
        RNBO_UNUSED(inProcess);
        RNBO_UNUSED(engine);
        this->_currentTime = time;
        auto offset = rnbo_fround(this->msToSamps(time - this->getEngine()->getCurrentTime(), this->sr));
    
        if (offset >= (SampleIndex)(this->vs))
            offset = (SampleIndex)(this->vs) - 1;
    
        if (offset < 0)
            offset = 0;
    
        this->sampleOffsetIntoNextAudioBuffer = (Index)(offset);
    }
    
    void assign_defaults()
    {
        ip_73_value = 0;
        ip_73_impulse = 0;
        ip_74_value = 0;
        ip_74_impulse = 0;
        ip_75_value = 0;
        ip_75_impulse = 0;
        ip_76_value = 0;
        ip_76_impulse = 0;
        ip_77_value = 0;
        ip_77_impulse = 0;
        ip_78_value = 0;
        ip_78_impulse = 0;
        ip_79_value = 0;
        ip_79_impulse = 0;
        ip_80_value = 0;
        ip_80_impulse = 0;
        ip_81_value = 0;
        ip_81_impulse = 0;
        ip_82_value = 0;
        ip_82_impulse = 0;
        ip_83_value = 0;
        ip_83_impulse = 0;
        ip_84_value = 0;
        ip_84_impulse = 0;
        codebox_tilde_07_in1 = 0;
        codebox_tilde_07_in2 = 0;
        codebox_tilde_07_in3 = 0;
        codebox_tilde_07_in4 = 0;
        codebox_tilde_07_in5 = 0;
        codebox_tilde_07_in6 = 0;
        codebox_tilde_07_in7 = 0;
        codebox_tilde_07_in8 = 0;
        codebox_tilde_07_in9 = 0;
        codebox_tilde_07_in10 = 0;
        codebox_tilde_07_in11 = 0;
        codebox_tilde_07_in12 = 0;
        codebox_tilde_07_in13 = 0;
        dspexpr_07_in1 = 0;
        dspexpr_07_in2 = 1;
        _currentTime = 0;
        audioProcessSampleCount = 0;
        sampleOffsetIntoNextAudioBuffer = 0;
        zeroBuffer = nullptr;
        dummyBuffer = nullptr;
        signals[0] = nullptr;
        signals[1] = nullptr;
        signals[2] = nullptr;
        signals[3] = nullptr;
        signals[4] = nullptr;
        signals[5] = nullptr;
        signals[6] = nullptr;
        signals[7] = nullptr;
        signals[8] = nullptr;
        signals[9] = nullptr;
        signals[10] = nullptr;
        signals[11] = nullptr;
        signals[12] = nullptr;
        signals[13] = nullptr;
        didAllocateSignals = 0;
        vs = 0;
        maxvs = 0;
        sr = 44100;
        invsr = 0.000022675736961451248;
        click_07_lastclick = -1;
        click_07_buf = nullptr;
        ip_73_lastIndex = 0;
        ip_73_lastValue = 0;
        ip_73_resetCount = 0;
        ip_73_sigbuf = nullptr;
        ip_73_setupDone = false;
        ip_74_lastIndex = 0;
        ip_74_lastValue = 0;
        ip_74_resetCount = 0;
        ip_74_sigbuf = nullptr;
        ip_74_setupDone = false;
        ip_75_lastIndex = 0;
        ip_75_lastValue = 0;
        ip_75_resetCount = 0;
        ip_75_sigbuf = nullptr;
        ip_75_setupDone = false;
        ip_76_lastIndex = 0;
        ip_76_lastValue = 0;
        ip_76_resetCount = 0;
        ip_76_sigbuf = nullptr;
        ip_76_setupDone = false;
        ip_77_lastIndex = 0;
        ip_77_lastValue = 0;
        ip_77_resetCount = 0;
        ip_77_sigbuf = nullptr;
        ip_77_setupDone = false;
        ip_78_lastIndex = 0;
        ip_78_lastValue = 0;
        ip_78_resetCount = 0;
        ip_78_sigbuf = nullptr;
        ip_78_setupDone = false;
        ip_79_lastIndex = 0;
        ip_79_lastValue = 0;
        ip_79_resetCount = 0;
        ip_79_sigbuf = nullptr;
        ip_79_setupDone = false;
        ip_80_lastIndex = 0;
        ip_80_lastValue = 0;
        ip_80_resetCount = 0;
        ip_80_sigbuf = nullptr;
        ip_80_setupDone = false;
        ip_81_lastIndex = 0;
        ip_81_lastValue = 0;
        ip_81_resetCount = 0;
        ip_81_sigbuf = nullptr;
        ip_81_setupDone = false;
        ip_82_lastIndex = 0;
        ip_82_lastValue = 0;
        ip_82_resetCount = 0;
        ip_82_sigbuf = nullptr;
        ip_82_setupDone = false;
        ip_83_lastIndex = 0;
        ip_83_lastValue = 0;
        ip_83_resetCount = 0;
        ip_83_sigbuf = nullptr;
        ip_83_setupDone = false;
        ip_84_lastIndex = 0;
        ip_84_lastValue = 0;
        ip_84_resetCount = 0;
        ip_84_sigbuf = nullptr;
        ip_84_setupDone = false;
        codebox_tilde_07_hitPitchHz = 440;
        codebox_tilde_07_hitDecayMs = 1600;
        codebox_tilde_07_hitFmRatio = 2.71;
        codebox_tilde_07_hitFmIndex = 3;
        codebox_tilde_07_hitFmDecayMs = 700;
        codebox_tilde_07_hitInharmonicity = 0.4;
        codebox_tilde_07_hitModeLevel = 0.3;
        codebox_tilde_07_hitModeDecayMs = 900;
        codebox_tilde_07_hitStrike = 0.2;
        codebox_tilde_07_hitBrightness = 0.65;
        codebox_tilde_07_hitDrive = 1;
        codebox_tilde_07_hitLevel = 0.35;
        codebox_tilde_07_active = 0;
        codebox_tilde_07_env = 0;
        codebox_tilde_07_fmEnv = 0;
        codebox_tilde_07_modeEnv = 0;
        codebox_tilde_07_strikeEnv = 0;
        codebox_tilde_07_envCoef = 0;
        codebox_tilde_07_fmCoef = 0;
        codebox_tilde_07_modeCoef = 0;
        codebox_tilde_07_strikeCoef = 0;
        codebox_tilde_07_phase = 0;
        codebox_tilde_07_modPhase = 0;
        codebox_tilde_07_mode1 = 0;
        codebox_tilde_07_mode2 = 0;
        codebox_tilde_07_noiseState = 34566;
        codebox_tilde_07_low = 0;
        codebox_tilde_07_lowCoef = 0;
        stackprotect_count = 0;
        _voiceIndex = 0;
        _noteNumber = 0;
        isMuted = 1;
        parameterOffset = 0;
    }
    
    // member variables
    
        number ip_73_value;
        number ip_73_impulse;
        number ip_74_value;
        number ip_74_impulse;
        number ip_75_value;
        number ip_75_impulse;
        number ip_76_value;
        number ip_76_impulse;
        number ip_77_value;
        number ip_77_impulse;
        number ip_78_value;
        number ip_78_impulse;
        number ip_79_value;
        number ip_79_impulse;
        number ip_80_value;
        number ip_80_impulse;
        number ip_81_value;
        number ip_81_impulse;
        number ip_82_value;
        number ip_82_impulse;
        number ip_83_value;
        number ip_83_impulse;
        number ip_84_value;
        number ip_84_impulse;
        number codebox_tilde_07_in1;
        number codebox_tilde_07_in2;
        number codebox_tilde_07_in3;
        number codebox_tilde_07_in4;
        number codebox_tilde_07_in5;
        number codebox_tilde_07_in6;
        number codebox_tilde_07_in7;
        number codebox_tilde_07_in8;
        number codebox_tilde_07_in9;
        number codebox_tilde_07_in10;
        number codebox_tilde_07_in11;
        number codebox_tilde_07_in12;
        number codebox_tilde_07_in13;
        number dspexpr_07_in1;
        number dspexpr_07_in2;
        MillisecondTime _currentTime;
        UInt64 audioProcessSampleCount;
        Index sampleOffsetIntoNextAudioBuffer;
        signal zeroBuffer;
        signal dummyBuffer;
        SampleValue * signals[14];
        bool didAllocateSignals;
        Index vs;
        Index maxvs;
        number sr;
        number invsr;
        SampleIndex click_07_lastclick;
        signal click_07_buf;
        SampleIndex ip_73_lastIndex;
        number ip_73_lastValue;
        SampleIndex ip_73_resetCount;
        signal ip_73_sigbuf;
        bool ip_73_setupDone;
        SampleIndex ip_74_lastIndex;
        number ip_74_lastValue;
        SampleIndex ip_74_resetCount;
        signal ip_74_sigbuf;
        bool ip_74_setupDone;
        SampleIndex ip_75_lastIndex;
        number ip_75_lastValue;
        SampleIndex ip_75_resetCount;
        signal ip_75_sigbuf;
        bool ip_75_setupDone;
        SampleIndex ip_76_lastIndex;
        number ip_76_lastValue;
        SampleIndex ip_76_resetCount;
        signal ip_76_sigbuf;
        bool ip_76_setupDone;
        SampleIndex ip_77_lastIndex;
        number ip_77_lastValue;
        SampleIndex ip_77_resetCount;
        signal ip_77_sigbuf;
        bool ip_77_setupDone;
        SampleIndex ip_78_lastIndex;
        number ip_78_lastValue;
        SampleIndex ip_78_resetCount;
        signal ip_78_sigbuf;
        bool ip_78_setupDone;
        SampleIndex ip_79_lastIndex;
        number ip_79_lastValue;
        SampleIndex ip_79_resetCount;
        signal ip_79_sigbuf;
        bool ip_79_setupDone;
        SampleIndex ip_80_lastIndex;
        number ip_80_lastValue;
        SampleIndex ip_80_resetCount;
        signal ip_80_sigbuf;
        bool ip_80_setupDone;
        SampleIndex ip_81_lastIndex;
        number ip_81_lastValue;
        SampleIndex ip_81_resetCount;
        signal ip_81_sigbuf;
        bool ip_81_setupDone;
        SampleIndex ip_82_lastIndex;
        number ip_82_lastValue;
        SampleIndex ip_82_resetCount;
        signal ip_82_sigbuf;
        bool ip_82_setupDone;
        SampleIndex ip_83_lastIndex;
        number ip_83_lastValue;
        SampleIndex ip_83_resetCount;
        signal ip_83_sigbuf;
        bool ip_83_setupDone;
        SampleIndex ip_84_lastIndex;
        number ip_84_lastValue;
        SampleIndex ip_84_resetCount;
        signal ip_84_sigbuf;
        bool ip_84_setupDone;
        number codebox_tilde_07_hitPitchHz;
        number codebox_tilde_07_hitDecayMs;
        number codebox_tilde_07_hitFmRatio;
        number codebox_tilde_07_hitFmIndex;
        number codebox_tilde_07_hitFmDecayMs;
        number codebox_tilde_07_hitInharmonicity;
        number codebox_tilde_07_hitModeLevel;
        number codebox_tilde_07_hitModeDecayMs;
        number codebox_tilde_07_hitStrike;
        number codebox_tilde_07_hitBrightness;
        number codebox_tilde_07_hitDrive;
        number codebox_tilde_07_hitLevel;
        number codebox_tilde_07_active;
        number codebox_tilde_07_env;
        number codebox_tilde_07_fmEnv;
        number codebox_tilde_07_modeEnv;
        number codebox_tilde_07_strikeEnv;
        number codebox_tilde_07_envCoef;
        number codebox_tilde_07_fmCoef;
        number codebox_tilde_07_modeCoef;
        number codebox_tilde_07_strikeCoef;
        number codebox_tilde_07_phase;
        number codebox_tilde_07_modPhase;
        number codebox_tilde_07_mode1;
        number codebox_tilde_07_mode2;
        number codebox_tilde_07_noiseState;
        number codebox_tilde_07_low;
        number codebox_tilde_07_lowCoef;
        number stackprotect_count;
        Index _voiceIndex;
        Int _noteNumber;
        Index isMuted;
        ParameterIndex parameterOffset;
        bool _isInitialized = false;
};

class RNBOSubpatcher_125 : public PatcherInterfaceImpl {
    
    friend class rnbomatic;
    
    public:
    
    RNBOSubpatcher_125()
    {}
    
    ~RNBOSubpatcher_125()
    {
        deallocateSignals();
    }
    
    Index getNumMidiInputPorts() const {
        return 0;
    }
    
    void processMidiEvent(MillisecondTime , int , ConstByteArray , Index ) {}
    
    Index getNumMidiOutputPorts() const {
        return 0;
    }
    
    void process(
        const SampleValue * const* inputs,
        Index numInputs,
        SampleValue * const* outputs,
        Index numOutputs,
        Index n
    ) {
        RNBO_UNUSED(numInputs);
        RNBO_UNUSED(inputs);
        this->vs = n;
        this->updateTime(this->getEngine()->getCurrentTime(), (ENGINE*)nullptr, true);
        SampleValue * out1 = (numOutputs >= 1 && outputs[0] ? outputs[0] : this->dummyBuffer);
        SampleValue * out2 = (numOutputs >= 2 && outputs[1] ? outputs[1] : this->dummyBuffer);
        this->click_08_perform(this->signals[0], n);
        this->ip_85_perform(this->signals[1], n);
        this->ip_86_perform(this->signals[2], n);
        this->ip_87_perform(this->signals[3], n);
        this->ip_88_perform(this->signals[4], n);
        this->ip_89_perform(this->signals[5], n);
        this->ip_90_perform(this->signals[6], n);
        this->ip_91_perform(this->signals[7], n);
        this->ip_92_perform(this->signals[8], n);
        this->ip_93_perform(this->signals[9], n);
        this->ip_94_perform(this->signals[10], n);
        this->ip_95_perform(this->signals[11], n);
        this->ip_96_perform(this->signals[12], n);
    
        this->codebox_tilde_08_perform(
            this->signals[0],
            this->signals[1],
            this->signals[2],
            this->signals[3],
            this->signals[4],
            this->signals[5],
            this->signals[6],
            this->signals[7],
            this->signals[8],
            this->signals[9],
            this->signals[10],
            this->signals[11],
            this->signals[12],
            this->signals[13],
            n
        );
    
        this->dspexpr_08_perform(this->signals[13], this->dspexpr_08_in2, this->signals[12], n);
        this->signalforwarder_15_perform(this->signals[12], out2, n);
        this->signalforwarder_16_perform(this->signals[12], out1, n);
        this->stackprotect_perform(n);
        this->audioProcessSampleCount += this->vs;
    }
    
    void prepareToProcess(number sampleRate, Index maxBlockSize, bool force) {
        RNBO_ASSERT(this->_isInitialized);
    
        if (this->maxvs < maxBlockSize || !this->didAllocateSignals) {
            Index i;
    
            for (i = 0; i < 14; i++) {
                this->signals[i] = resizeSignal(this->signals[i], this->maxvs, maxBlockSize);
            }
    
            this->click_08_buf = resizeSignal(this->click_08_buf, this->maxvs, maxBlockSize);
            this->ip_85_sigbuf = resizeSignal(this->ip_85_sigbuf, this->maxvs, maxBlockSize);
            this->ip_86_sigbuf = resizeSignal(this->ip_86_sigbuf, this->maxvs, maxBlockSize);
            this->ip_87_sigbuf = resizeSignal(this->ip_87_sigbuf, this->maxvs, maxBlockSize);
            this->ip_88_sigbuf = resizeSignal(this->ip_88_sigbuf, this->maxvs, maxBlockSize);
            this->ip_89_sigbuf = resizeSignal(this->ip_89_sigbuf, this->maxvs, maxBlockSize);
            this->ip_90_sigbuf = resizeSignal(this->ip_90_sigbuf, this->maxvs, maxBlockSize);
            this->ip_91_sigbuf = resizeSignal(this->ip_91_sigbuf, this->maxvs, maxBlockSize);
            this->ip_92_sigbuf = resizeSignal(this->ip_92_sigbuf, this->maxvs, maxBlockSize);
            this->ip_93_sigbuf = resizeSignal(this->ip_93_sigbuf, this->maxvs, maxBlockSize);
            this->ip_94_sigbuf = resizeSignal(this->ip_94_sigbuf, this->maxvs, maxBlockSize);
            this->ip_95_sigbuf = resizeSignal(this->ip_95_sigbuf, this->maxvs, maxBlockSize);
            this->ip_96_sigbuf = resizeSignal(this->ip_96_sigbuf, this->maxvs, maxBlockSize);
            this->zeroBuffer = resizeSignal(this->zeroBuffer, this->maxvs, maxBlockSize);
            this->dummyBuffer = resizeSignal(this->dummyBuffer, this->maxvs, maxBlockSize);
            this->didAllocateSignals = true;
        }
    
        const bool sampleRateChanged = sampleRate != this->sr;
        const bool maxvsChanged = maxBlockSize != this->maxvs;
        const bool forceDSPSetup = sampleRateChanged || maxvsChanged || force;
    
        if (sampleRateChanged || maxvsChanged) {
            this->vs = maxBlockSize;
            this->maxvs = maxBlockSize;
            this->sr = sampleRate;
            this->invsr = 1 / sampleRate;
        }
    
        this->ip_85_dspsetup(forceDSPSetup);
        this->ip_86_dspsetup(forceDSPSetup);
        this->ip_87_dspsetup(forceDSPSetup);
        this->ip_88_dspsetup(forceDSPSetup);
        this->ip_89_dspsetup(forceDSPSetup);
        this->ip_90_dspsetup(forceDSPSetup);
        this->ip_91_dspsetup(forceDSPSetup);
        this->ip_92_dspsetup(forceDSPSetup);
        this->ip_93_dspsetup(forceDSPSetup);
        this->ip_94_dspsetup(forceDSPSetup);
        this->ip_95_dspsetup(forceDSPSetup);
        this->ip_96_dspsetup(forceDSPSetup);
    
        if (sampleRateChanged)
            this->onSampleRateChanged(sampleRate);
    }
    
    number msToSamps(MillisecondTime ms, number sampleRate) {
        return ms * sampleRate * 0.001;
    }
    
    MillisecondTime sampsToMs(SampleIndex samps) {
        return samps * (this->invsr * 1000);
    }
    
    Index getNumInputChannels() const {
        return 0;
    }
    
    Index getNumOutputChannels() const {
        return 2;
    }
    
    void getPreset(PatcherStateInterface& ) {}
    
    void setPreset(MillisecondTime , PatcherStateInterface& ) {}
    
    void setParameterValue(ParameterIndex , ParameterValue , MillisecondTime ) {}
    
    void processParameterEvent(ParameterIndex index, ParameterValue value, MillisecondTime time) {
        this->setParameterValue(index, value, time);
    }
    
    void processParameterBangEvent(ParameterIndex index, MillisecondTime time) {
        this->setParameterValue(index, this->getParameterValue(index), time);
    }
    
    void processNormalizedParameterEvent(ParameterIndex index, ParameterValue value, MillisecondTime time) {
        this->setParameterValueNormalized(index, value, time);
    }
    
    ParameterValue getParameterValue(ParameterIndex index)  {
        switch (index) {
        default:
            {
            return 0;
            }
        }
    }
    
    ParameterIndex getNumSignalInParameters() const {
        return 0;
    }
    
    ParameterIndex getNumSignalOutParameters() const {
        return 0;
    }
    
    ParameterIndex getNumParameters() const {
        return 0;
    }
    
    ConstCharPointer getParameterName(ParameterIndex index) const {
        switch (index) {
        default:
            {
            return "bogus";
            }
        }
    }
    
    ConstCharPointer getParameterId(ParameterIndex index) const {
        switch (index) {
        default:
            {
            return "bogus";
            }
        }
    }
    
    void getParameterInfo(ParameterIndex , ParameterInfo * ) const {}
    
    ParameterValue applyStepsToNormalizedParameterValue(ParameterValue normalizedValue, int steps) const {
        if (steps == 1) {
            if (normalizedValue > 0) {
                normalizedValue = 1.;
            }
        } else {
            ParameterValue oneStep = (number)1. / (steps - 1);
            ParameterValue numberOfSteps = rnbo_fround(normalizedValue / oneStep * 1 / (number)1) * (number)1;
            normalizedValue = numberOfSteps * oneStep;
        }
    
        return normalizedValue;
    }
    
    ParameterValue convertToNormalizedParameterValue(ParameterIndex index, ParameterValue value) const {
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    ParameterValue convertFromNormalizedParameterValue(ParameterIndex index, ParameterValue value) const {
        value = (value < 0 ? 0 : (value > 1 ? 1 : value));
    
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    ParameterValue constrainParameterValue(ParameterIndex index, ParameterValue value) const {
        switch (index) {
        default:
            {
            return value;
            }
        }
    }
    
    void processNumMessage(MessageTag , MessageTag , MillisecondTime , number ) {}
    
    void processListMessage(MessageTag , MessageTag , MillisecondTime , const list& ) {}
    
    void processBangMessage(MessageTag , MessageTag , MillisecondTime ) {}
    
    MessageTagInfo resolveTag(MessageTag tag) const {
        switch (tag) {
    
        }
    
        return nullptr;
    }
    
    DataRef* getDataRef(DataRefIndex index)  {
        switch (index) {
        default:
            {
            return nullptr;
            }
        }
    }
    
    DataRefIndex getNumDataRefs() const {
        return 0;
    }
    
    void processDataViewUpdate(DataRefIndex , MillisecondTime ) {}
    
    void initialize() {
        RNBO_ASSERT(!this->_isInitialized);
        this->assign_defaults();
        this->applyState();
        this->_isInitialized = true;
    }
    
    protected:
    
    void updateTime(MillisecondTime time, INTERNALENGINE*, bool inProcess = false) {
    	if (time == TimeNow) time = getTopLevelPatcher()->getPatcherTime();
    	getTopLevelPatcher()->processInternalEvents(time);
    	updateTime(time, (EXTERNALENGINE*)nullptr);
    }
    
    RNBOSubpatcher_125* operator->() {
        return this;
    }
    const RNBOSubpatcher_125* operator->() const {
        return this;
    }
    virtual rnbomatic* getPatcher() const {
        return static_cast<rnbomatic *>(_parentPatcher);
    }
    
    rnbomatic* getTopLevelPatcher() {
        return this->getPatcher()->getTopLevelPatcher();
    }
    
    void cancelClockEvents()
    {
    }
    
    number maximum(number x, number y) {
        return (x < y ? y : x);
    }
    
    number minimum(number x, number y) {
        return (y < x ? y : x);
    }
    
    number wrap(number x, number low, number high) {
        number lo;
        number hi;
    
        if (low == high)
            return low;
    
        if (low > high) {
            hi = low;
            lo = high;
        } else {
            lo = low;
            hi = high;
        }
    
        number range = hi - lo;
    
        if (x >= lo && x < hi)
            return x;
    
        if (range <= 0.000000001)
            return lo;
    
        Int numWraps = (Int)(trunc((x - lo) / range));
        numWraps = numWraps - ((x < lo ? 1 : 0));
        number result = x - range * numWraps;
    
        if (result >= hi)
            return result - range;
        else
            return result;
    }
    
    MillisecondTime getPatcherTime() const {
        return this->_currentTime;
    }
    
    void eventinlet_93_out1_bang_bang() {
        this->ip_85_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_93_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_85_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_85_value_set(converted);
        }
    }
    
    void eventinlet_94_out1_bang_bang() {
        this->ip_86_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_94_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_86_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_86_value_set(converted);
        }
    }
    
    void eventinlet_95_out1_bang_bang() {
        this->ip_87_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_95_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_87_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_87_value_set(converted);
        }
    }
    
    void eventinlet_96_out1_bang_bang() {
        this->ip_88_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_96_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_88_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_88_value_set(converted);
        }
    }
    
    void eventinlet_97_out1_bang_bang() {
        this->ip_89_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_97_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_89_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_89_value_set(converted);
        }
    }
    
    void eventinlet_98_out1_bang_bang() {
        this->ip_90_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_98_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_90_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_90_value_set(converted);
        }
    }
    
    void eventinlet_99_out1_bang_bang() {
        this->ip_91_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_99_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_91_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_91_value_set(converted);
        }
    }
    
    void eventinlet_100_out1_bang_bang() {
        this->ip_92_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_100_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_92_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_92_value_set(converted);
        }
    }
    
    void eventinlet_101_out1_bang_bang() {
        this->ip_93_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_101_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_93_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_93_value_set(converted);
        }
    }
    
    void eventinlet_102_out1_bang_bang() {
        this->ip_94_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_102_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_94_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_94_value_set(converted);
        }
    }
    
    void eventinlet_103_out1_bang_bang() {
        this->ip_95_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_103_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_95_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_95_value_set(converted);
        }
    }
    
    void eventinlet_104_out1_bang_bang() {
        this->ip_96_value_bang();
    }
    
    template<typename LISTTYPE> void eventinlet_104_out1_list_set(const LISTTYPE& v) {
        {
            if (v->length > 1)
                this->ip_96_impulse_set(v[1]);
    
            number converted = (v->length > 0 ? v[0] : 0);
            this->ip_96_value_set(converted);
        }
    }
    
    void deallocateSignals() {
        Index i;
    
        for (i = 0; i < 14; i++) {
            this->signals[i] = freeSignal(this->signals[i]);
        }
    
        this->click_08_buf = freeSignal(this->click_08_buf);
        this->ip_85_sigbuf = freeSignal(this->ip_85_sigbuf);
        this->ip_86_sigbuf = freeSignal(this->ip_86_sigbuf);
        this->ip_87_sigbuf = freeSignal(this->ip_87_sigbuf);
        this->ip_88_sigbuf = freeSignal(this->ip_88_sigbuf);
        this->ip_89_sigbuf = freeSignal(this->ip_89_sigbuf);
        this->ip_90_sigbuf = freeSignal(this->ip_90_sigbuf);
        this->ip_91_sigbuf = freeSignal(this->ip_91_sigbuf);
        this->ip_92_sigbuf = freeSignal(this->ip_92_sigbuf);
        this->ip_93_sigbuf = freeSignal(this->ip_93_sigbuf);
        this->ip_94_sigbuf = freeSignal(this->ip_94_sigbuf);
        this->ip_95_sigbuf = freeSignal(this->ip_95_sigbuf);
        this->ip_96_sigbuf = freeSignal(this->ip_96_sigbuf);
        this->zeroBuffer = freeSignal(this->zeroBuffer);
        this->dummyBuffer = freeSignal(this->dummyBuffer);
    }
    
    Index getMaxBlockSize() const {
        return this->maxvs;
    }
    
    number getSampleRate() const {
        return this->sr;
    }
    
    bool hasFixedVectorSize() const {
        return false;
    }
    
    void setProbingTarget(MessageTag ) {}
    
    void initializeObjects() {
        this->ip_85_init();
        this->ip_86_init();
        this->ip_87_init();
        this->ip_88_init();
        this->ip_89_init();
        this->ip_90_init();
        this->ip_91_init();
        this->ip_92_init();
        this->ip_93_init();
        this->ip_94_init();
        this->ip_95_init();
        this->ip_96_init();
    }
    
    Index getIsMuted()  {
        return this->isMuted;
    }
    
    void setIsMuted(Index v)  {
        this->isMuted = v;
    }
    
    void onSampleRateChanged(double ) {}
    
    void extractState(PatcherStateInterface& ) {}
    
    void applyState() {}
    
    void setParameterOffset(ParameterIndex offset) {
        this->parameterOffset = offset;
    }
    
    void processClockEvent(MillisecondTime , ClockId , bool , ParameterValue ) {}
    
    void processOutletAtCurrentTime(EngineLink* , OutletIndex , ParameterValue ) {}
    
    void processOutletEvent(
        EngineLink* sender,
        OutletIndex index,
        ParameterValue value,
        MillisecondTime time
    ) {
        this->updateTime(time, (ENGINE*)nullptr);
        this->processOutletAtCurrentTime(sender, index, value);
    }
    
    void sendOutlet(OutletIndex index, ParameterValue value) {
        this->getEngine()->sendOutlet(this, index, value);
    }
    
    void startup() {}
    
    void fillDataRef(DataRefIndex , DataRef& ) {}
    
    void allocateDataRefs() {}
    
    void ip_85_value_set(number v) {
        this->ip_85_value = v;
        this->ip_85_fillSigBuf();
        this->ip_85_lastValue = v;
    }
    
    void eventinlet_93_out1_number_set(number v) {
        this->ip_85_value_set(v);
    }
    
    void ip_88_value_set(number v) {
        this->ip_88_value = v;
        this->ip_88_fillSigBuf();
        this->ip_88_lastValue = v;
    }
    
    void eventinlet_96_out1_number_set(number v) {
        this->ip_88_value_set(v);
    }
    
    void ip_89_value_set(number v) {
        this->ip_89_value = v;
        this->ip_89_fillSigBuf();
        this->ip_89_lastValue = v;
    }
    
    void eventinlet_97_out1_number_set(number v) {
        this->ip_89_value_set(v);
    }
    
    void ip_86_value_set(number v) {
        this->ip_86_value = v;
        this->ip_86_fillSigBuf();
        this->ip_86_lastValue = v;
    }
    
    void eventinlet_94_out1_number_set(number v) {
        this->ip_86_value_set(v);
    }
    
    void ip_87_value_set(number v) {
        this->ip_87_value = v;
        this->ip_87_fillSigBuf();
        this->ip_87_lastValue = v;
    }
    
    void eventinlet_95_out1_number_set(number v) {
        this->ip_87_value_set(v);
    }
    
    void ip_90_value_set(number v) {
        this->ip_90_value = v;
        this->ip_90_fillSigBuf();
        this->ip_90_lastValue = v;
    }
    
    void eventinlet_98_out1_number_set(number v) {
        this->ip_90_value_set(v);
    }
    
    void ip_93_value_set(number v) {
        this->ip_93_value = v;
        this->ip_93_fillSigBuf();
        this->ip_93_lastValue = v;
    }
    
    void eventinlet_101_out1_number_set(number v) {
        this->ip_93_value_set(v);
    }
    
    void ip_94_value_set(number v) {
        this->ip_94_value = v;
        this->ip_94_fillSigBuf();
        this->ip_94_lastValue = v;
    }
    
    void eventinlet_102_out1_number_set(number v) {
        this->ip_94_value_set(v);
    }
    
    void ip_95_value_set(number v) {
        this->ip_95_value = v;
        this->ip_95_fillSigBuf();
        this->ip_95_lastValue = v;
    }
    
    void eventinlet_103_out1_number_set(number v) {
        this->ip_95_value_set(v);
    }
    
    void ip_91_value_set(number v) {
        this->ip_91_value = v;
        this->ip_91_fillSigBuf();
        this->ip_91_lastValue = v;
    }
    
    void eventinlet_99_out1_number_set(number v) {
        this->ip_91_value_set(v);
    }
    
    void ip_92_value_set(number v) {
        this->ip_92_value = v;
        this->ip_92_fillSigBuf();
        this->ip_92_lastValue = v;
    }
    
    void eventinlet_100_out1_number_set(number v) {
        this->ip_92_value_set(v);
    }
    
    void ip_96_value_set(number v) {
        this->ip_96_value = v;
        this->ip_96_fillSigBuf();
        this->ip_96_lastValue = v;
    }
    
    void eventinlet_104_out1_number_set(number v) {
        this->ip_96_value_set(v);
    }
    
    void click_08_click_number_set(number v) {
        for (SampleIndex i = (SampleIndex)(this->click_08_lastclick + 1); i < this->sampleOffsetIntoNextAudioBuffer; i++) {
            this->click_08_buf[(Index)i] = 0;
        }
    
        this->click_08_lastclick = this->sampleOffsetIntoNextAudioBuffer;
        this->click_08_buf[(Index)this->click_08_lastclick] = v;
    }
    
    void click_08_click_bang_bang() {
        this->click_08_click_number_set(1);
    }
    
    void eventinlet_92_out1_bang_bang() {
        this->click_08_click_bang_bang();
    }
    
    void eventinlet_92_out1_number_set(number v) {
        this->click_08_click_number_set(v);
    }
    
    template<typename LISTTYPE> void eventinlet_92_out1_list_set(const LISTTYPE& v) {
        {
            number converted = (v->length > 0 ? v[0] : 0);
            this->click_08_click_number_set(converted);
        }
    }
    
    void ip_85_value_bang() {
        number v = this->ip_85_value;
        this->ip_85_fillSigBuf();
        this->ip_85_lastValue = v;
    }
    
    void ip_85_impulse_set(number v) {
        this->ip_85_impulse = v;
        this->ip_85_fillSigBuf();
        this->ip_85_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_85_resetCount = lengthInSamples;
    }
    
    void ip_86_value_bang() {
        number v = this->ip_86_value;
        this->ip_86_fillSigBuf();
        this->ip_86_lastValue = v;
    }
    
    void ip_86_impulse_set(number v) {
        this->ip_86_impulse = v;
        this->ip_86_fillSigBuf();
        this->ip_86_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_86_resetCount = lengthInSamples;
    }
    
    void ip_87_value_bang() {
        number v = this->ip_87_value;
        this->ip_87_fillSigBuf();
        this->ip_87_lastValue = v;
    }
    
    void ip_87_impulse_set(number v) {
        this->ip_87_impulse = v;
        this->ip_87_fillSigBuf();
        this->ip_87_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_87_resetCount = lengthInSamples;
    }
    
    void ip_88_value_bang() {
        number v = this->ip_88_value;
        this->ip_88_fillSigBuf();
        this->ip_88_lastValue = v;
    }
    
    void ip_88_impulse_set(number v) {
        this->ip_88_impulse = v;
        this->ip_88_fillSigBuf();
        this->ip_88_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_88_resetCount = lengthInSamples;
    }
    
    void ip_89_value_bang() {
        number v = this->ip_89_value;
        this->ip_89_fillSigBuf();
        this->ip_89_lastValue = v;
    }
    
    void ip_89_impulse_set(number v) {
        this->ip_89_impulse = v;
        this->ip_89_fillSigBuf();
        this->ip_89_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_89_resetCount = lengthInSamples;
    }
    
    void ip_90_value_bang() {
        number v = this->ip_90_value;
        this->ip_90_fillSigBuf();
        this->ip_90_lastValue = v;
    }
    
    void ip_90_impulse_set(number v) {
        this->ip_90_impulse = v;
        this->ip_90_fillSigBuf();
        this->ip_90_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_90_resetCount = lengthInSamples;
    }
    
    void ip_91_value_bang() {
        number v = this->ip_91_value;
        this->ip_91_fillSigBuf();
        this->ip_91_lastValue = v;
    }
    
    void ip_91_impulse_set(number v) {
        this->ip_91_impulse = v;
        this->ip_91_fillSigBuf();
        this->ip_91_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_91_resetCount = lengthInSamples;
    }
    
    void ip_92_value_bang() {
        number v = this->ip_92_value;
        this->ip_92_fillSigBuf();
        this->ip_92_lastValue = v;
    }
    
    void ip_92_impulse_set(number v) {
        this->ip_92_impulse = v;
        this->ip_92_fillSigBuf();
        this->ip_92_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_92_resetCount = lengthInSamples;
    }
    
    void ip_93_value_bang() {
        number v = this->ip_93_value;
        this->ip_93_fillSigBuf();
        this->ip_93_lastValue = v;
    }
    
    void ip_93_impulse_set(number v) {
        this->ip_93_impulse = v;
        this->ip_93_fillSigBuf();
        this->ip_93_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_93_resetCount = lengthInSamples;
    }
    
    void ip_94_value_bang() {
        number v = this->ip_94_value;
        this->ip_94_fillSigBuf();
        this->ip_94_lastValue = v;
    }
    
    void ip_94_impulse_set(number v) {
        this->ip_94_impulse = v;
        this->ip_94_fillSigBuf();
        this->ip_94_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_94_resetCount = lengthInSamples;
    }
    
    void ip_95_value_bang() {
        number v = this->ip_95_value;
        this->ip_95_fillSigBuf();
        this->ip_95_lastValue = v;
    }
    
    void ip_95_impulse_set(number v) {
        this->ip_95_impulse = v;
        this->ip_95_fillSigBuf();
        this->ip_95_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_95_resetCount = lengthInSamples;
    }
    
    void ip_96_value_bang() {
        number v = this->ip_96_value;
        this->ip_96_fillSigBuf();
        this->ip_96_lastValue = v;
    }
    
    void ip_96_impulse_set(number v) {
        this->ip_96_impulse = v;
        this->ip_96_fillSigBuf();
        this->ip_96_lastValue = 0;
        SampleIndex lengthInSamples = (SampleIndex)(this->maximum(1, this->msToSamps(v, this->sr)));
        this->ip_96_resetCount = lengthInSamples;
    }
    
    void click_08_perform(SampleValue * out, Index n) {
        auto __click_08_lastclick = this->click_08_lastclick;
    
        for (SampleIndex i = 0; i <= __click_08_lastclick; i++) {
            out[(Index)i] = this->click_08_buf[(Index)i];
        }
    
        for (SampleIndex i = (SampleIndex)(__click_08_lastclick + 1); i < (SampleIndex)(n); i++) {
            out[(Index)i] = 0;
        }
    
        __click_08_lastclick = -1;
        this->click_08_lastclick = __click_08_lastclick;
    }
    
    void ip_85_perform(SampleValue * out, Index n) {
        auto __ip_85_lastValue = this->ip_85_lastValue;
        auto __ip_85_lastIndex = this->ip_85_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_85_lastIndex ? __ip_85_lastValue : this->ip_85_sigbuf[(Index)i]);
        }
    
        __ip_85_lastIndex = 0;
        this->ip_85_lastIndex = __ip_85_lastIndex;
    }
    
    void ip_86_perform(SampleValue * out, Index n) {
        auto __ip_86_lastValue = this->ip_86_lastValue;
        auto __ip_86_lastIndex = this->ip_86_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_86_lastIndex ? __ip_86_lastValue : this->ip_86_sigbuf[(Index)i]);
        }
    
        __ip_86_lastIndex = 0;
        this->ip_86_lastIndex = __ip_86_lastIndex;
    }
    
    void ip_87_perform(SampleValue * out, Index n) {
        auto __ip_87_lastValue = this->ip_87_lastValue;
        auto __ip_87_lastIndex = this->ip_87_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_87_lastIndex ? __ip_87_lastValue : this->ip_87_sigbuf[(Index)i]);
        }
    
        __ip_87_lastIndex = 0;
        this->ip_87_lastIndex = __ip_87_lastIndex;
    }
    
    void ip_88_perform(SampleValue * out, Index n) {
        auto __ip_88_lastValue = this->ip_88_lastValue;
        auto __ip_88_lastIndex = this->ip_88_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_88_lastIndex ? __ip_88_lastValue : this->ip_88_sigbuf[(Index)i]);
        }
    
        __ip_88_lastIndex = 0;
        this->ip_88_lastIndex = __ip_88_lastIndex;
    }
    
    void ip_89_perform(SampleValue * out, Index n) {
        auto __ip_89_lastValue = this->ip_89_lastValue;
        auto __ip_89_lastIndex = this->ip_89_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_89_lastIndex ? __ip_89_lastValue : this->ip_89_sigbuf[(Index)i]);
        }
    
        __ip_89_lastIndex = 0;
        this->ip_89_lastIndex = __ip_89_lastIndex;
    }
    
    void ip_90_perform(SampleValue * out, Index n) {
        auto __ip_90_lastValue = this->ip_90_lastValue;
        auto __ip_90_lastIndex = this->ip_90_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_90_lastIndex ? __ip_90_lastValue : this->ip_90_sigbuf[(Index)i]);
        }
    
        __ip_90_lastIndex = 0;
        this->ip_90_lastIndex = __ip_90_lastIndex;
    }
    
    void ip_91_perform(SampleValue * out, Index n) {
        auto __ip_91_lastValue = this->ip_91_lastValue;
        auto __ip_91_lastIndex = this->ip_91_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_91_lastIndex ? __ip_91_lastValue : this->ip_91_sigbuf[(Index)i]);
        }
    
        __ip_91_lastIndex = 0;
        this->ip_91_lastIndex = __ip_91_lastIndex;
    }
    
    void ip_92_perform(SampleValue * out, Index n) {
        auto __ip_92_lastValue = this->ip_92_lastValue;
        auto __ip_92_lastIndex = this->ip_92_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_92_lastIndex ? __ip_92_lastValue : this->ip_92_sigbuf[(Index)i]);
        }
    
        __ip_92_lastIndex = 0;
        this->ip_92_lastIndex = __ip_92_lastIndex;
    }
    
    void ip_93_perform(SampleValue * out, Index n) {
        auto __ip_93_lastValue = this->ip_93_lastValue;
        auto __ip_93_lastIndex = this->ip_93_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_93_lastIndex ? __ip_93_lastValue : this->ip_93_sigbuf[(Index)i]);
        }
    
        __ip_93_lastIndex = 0;
        this->ip_93_lastIndex = __ip_93_lastIndex;
    }
    
    void ip_94_perform(SampleValue * out, Index n) {
        auto __ip_94_lastValue = this->ip_94_lastValue;
        auto __ip_94_lastIndex = this->ip_94_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_94_lastIndex ? __ip_94_lastValue : this->ip_94_sigbuf[(Index)i]);
        }
    
        __ip_94_lastIndex = 0;
        this->ip_94_lastIndex = __ip_94_lastIndex;
    }
    
    void ip_95_perform(SampleValue * out, Index n) {
        auto __ip_95_lastValue = this->ip_95_lastValue;
        auto __ip_95_lastIndex = this->ip_95_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_95_lastIndex ? __ip_95_lastValue : this->ip_95_sigbuf[(Index)i]);
        }
    
        __ip_95_lastIndex = 0;
        this->ip_95_lastIndex = __ip_95_lastIndex;
    }
    
    void ip_96_perform(SampleValue * out, Index n) {
        auto __ip_96_lastValue = this->ip_96_lastValue;
        auto __ip_96_lastIndex = this->ip_96_lastIndex;
    
        for (Index i = 0; i < n; i++) {
            out[(Index)i] = ((SampleIndex)(i) >= __ip_96_lastIndex ? __ip_96_lastValue : this->ip_96_sigbuf[(Index)i]);
        }
    
        __ip_96_lastIndex = 0;
        this->ip_96_lastIndex = __ip_96_lastIndex;
    }
    
    void codebox_tilde_08_perform(
        const Sample * in1,
        const Sample * in2,
        const Sample * in3,
        const Sample * in4,
        const Sample * in5,
        const Sample * in6,
        const Sample * in7,
        const Sample * in8,
        const Sample * in9,
        const Sample * in10,
        const Sample * in11,
        const Sample * in12,
        const Sample * in13,
        SampleValue * out1,
        Index n
    ) {
        auto __codebox_tilde_08_lowCoef = this->codebox_tilde_08_lowCoef;
        auto __codebox_tilde_08_bendCoef = this->codebox_tilde_08_bendCoef;
        auto __codebox_tilde_08_attackCoef = this->codebox_tilde_08_attackCoef;
        auto __codebox_tilde_08_fmCoef = this->codebox_tilde_08_fmCoef;
        auto __codebox_tilde_08_envCoef = this->codebox_tilde_08_envCoef;
        auto __codebox_tilde_08_baseHz = this->codebox_tilde_08_baseHz;
        auto __codebox_tilde_08_low = this->codebox_tilde_08_low;
        auto __codebox_tilde_08_modLast = this->codebox_tilde_08_modLast;
        auto __codebox_tilde_08_subPhase = this->codebox_tilde_08_subPhase;
        auto __codebox_tilde_08_modPhase = this->codebox_tilde_08_modPhase;
        auto __codebox_tilde_08_phase = this->codebox_tilde_08_phase;
        auto __codebox_tilde_08_bendEnv = this->codebox_tilde_08_bendEnv;
        auto __codebox_tilde_08_attackEnv = this->codebox_tilde_08_attackEnv;
        auto __codebox_tilde_08_fmEnv = this->codebox_tilde_08_fmEnv;
        auto __codebox_tilde_08_env = this->codebox_tilde_08_env;
        auto __codebox_tilde_08_active = this->codebox_tilde_08_active;
        auto __codebox_tilde_08_hitLevel = this->codebox_tilde_08_hitLevel;
        auto __codebox_tilde_08_hitDrive = this->codebox_tilde_08_hitDrive;
        auto __codebox_tilde_08_hitBendSemitones = this->codebox_tilde_08_hitBendSemitones;
        auto __codebox_tilde_08_hitAttackMs = this->codebox_tilde_08_hitAttackMs;
        auto __codebox_tilde_08_hitBrightness = this->codebox_tilde_08_hitBrightness;
        auto __codebox_tilde_08_hitSubLevel = this->codebox_tilde_08_hitSubLevel;
        auto __codebox_tilde_08_hitFeedback = this->codebox_tilde_08_hitFeedback;
        auto __codebox_tilde_08_hitFmDecayMs = this->codebox_tilde_08_hitFmDecayMs;
        auto __codebox_tilde_08_hitFmRatio = this->codebox_tilde_08_hitFmRatio;
        auto __codebox_tilde_08_hitFmIndex = this->codebox_tilde_08_hitFmIndex;
        auto __codebox_tilde_08_hitDecayMs = this->codebox_tilde_08_hitDecayMs;
        auto __codebox_tilde_08_hitNote = this->codebox_tilde_08_hitNote;
        Index i;
    
        for (i = 0; i < (Index)n; i++) {
            number trig = in1[(Index)i];
            number sr = this->sr;
    
            if (trig > 0) {
                __codebox_tilde_08_hitNote = in2[(Index)i];//#map:_###_obj_###_:33
                __codebox_tilde_08_hitDecayMs = in3[(Index)i];//#map:_###_obj_###_:34
                __codebox_tilde_08_hitFmIndex = in4[(Index)i];//#map:_###_obj_###_:35
                __codebox_tilde_08_hitFmRatio = in5[(Index)i];//#map:_###_obj_###_:36
                __codebox_tilde_08_hitFmDecayMs = in6[(Index)i];//#map:_###_obj_###_:37
                __codebox_tilde_08_hitFeedback = in7[(Index)i];//#map:_###_obj_###_:38
                __codebox_tilde_08_hitSubLevel = in8[(Index)i];//#map:_###_obj_###_:39
                __codebox_tilde_08_hitBrightness = in9[(Index)i];//#map:_###_obj_###_:40
                __codebox_tilde_08_hitAttackMs = in10[(Index)i];//#map:_###_obj_###_:41
                __codebox_tilde_08_hitBendSemitones = in11[(Index)i];//#map:_###_obj_###_:42
                __codebox_tilde_08_hitDrive = in12[(Index)i];//#map:_###_obj_###_:43
                __codebox_tilde_08_hitLevel = in13[(Index)i];//#map:_###_obj_###_:44
            }//#map:_###_obj_###_:32
    
            if (trig > 0) {
                __codebox_tilde_08_active = 1;//#map:_###_obj_###_:47
                __codebox_tilde_08_env = 1;//#map:_###_obj_###_:48
                __codebox_tilde_08_fmEnv = 1;//#map:_###_obj_###_:48
                __codebox_tilde_08_attackEnv = 0;//#map:_###_obj_###_:48
                __codebox_tilde_08_bendEnv = 1;//#map:_###_obj_###_:48
                __codebox_tilde_08_phase = 0;//#map:_###_obj_###_:49
                __codebox_tilde_08_modPhase = 0;//#map:_###_obj_###_:49
                __codebox_tilde_08_subPhase = 0;//#map:_###_obj_###_:49
                __codebox_tilde_08_modLast = 0;//#map:_###_obj_###_:49
                __codebox_tilde_08_low = 0;//#map:_###_obj_###_:49
    
                __codebox_tilde_08_baseHz = 440 * fixnan(rnbo_pow(2, (rnbo_floor(
                    ((__codebox_tilde_08_hitNote > 96 ? 96 : (__codebox_tilde_08_hitNote < 12 ? 12 : __codebox_tilde_08_hitNote))) + 0.5
                ) - 69) / (number)12));//#map:_###_obj_###_:50
    
                __codebox_tilde_08_envCoef = rnbo_exp(
                    (this->maximum(10, __codebox_tilde_08_hitDecayMs) * 0.001 * sr == 0. ? 0. : -6.907755 / (this->maximum(10, __codebox_tilde_08_hitDecayMs) * 0.001 * sr))
                );//#map:_###_obj_###_:51
    
                __codebox_tilde_08_fmCoef = rnbo_exp(
                    (this->maximum(5, __codebox_tilde_08_hitFmDecayMs) * 0.001 * sr == 0. ? 0. : -6.907755 / (this->maximum(5, __codebox_tilde_08_hitFmDecayMs) * 0.001 * sr))
                );//#map:_###_obj_###_:52
    
                __codebox_tilde_08_attackCoef = rnbo_exp(
                    (this->maximum(0.2, __codebox_tilde_08_hitAttackMs) * 0.001 * sr == 0. ? 0. : -4.60517 / (this->maximum(0.2, __codebox_tilde_08_hitAttackMs) * 0.001 * sr))
                );//#map:_###_obj_###_:53
    
                __codebox_tilde_08_bendCoef = rnbo_exp((0.04 * sr == 0. ? 0. : -6.907755 / (0.04 * sr)));//#map:_###_obj_###_:54
    
                __codebox_tilde_08_lowCoef = rnbo_exp((sr == 0. ? 0. : -6.283185307179586 * this->minimum(
                    150 + 14000 * __codebox_tilde_08_hitBrightness * __codebox_tilde_08_hitBrightness,
                    sr * 0.45
                ) / sr));//#map:_###_obj_###_:55
            }//#map:_###_obj_###_:46
    
            out1[(Index)i] = 0;//#map:_###_obj_###_:57
    
            if (__codebox_tilde_08_active > 0) {
                __codebox_tilde_08_env *= __codebox_tilde_08_envCoef;//#map:_###_obj_###_:59
                __codebox_tilde_08_fmEnv *= __codebox_tilde_08_fmCoef;//#map:_###_obj_###_:59
                __codebox_tilde_08_bendEnv *= __codebox_tilde_08_bendCoef;//#map:_###_obj_###_:59
                __codebox_tilde_08_attackEnv = 1 - (1 - __codebox_tilde_08_attackEnv) * __codebox_tilde_08_attackCoef;//#map:_###_obj_###_:60
    
                auto hz = this->minimum(__codebox_tilde_08_baseHz * fixnan(rnbo_pow(
                    2,
                    __codebox_tilde_08_hitBendSemitones * __codebox_tilde_08_bendEnv / (number)12
                )), sr * 0.2);
    
                __codebox_tilde_08_phase = this->wrap(__codebox_tilde_08_phase + ((sr == 0. ? 0. : hz / sr)), 0, 1);//#map:_###_obj_###_:62
    
                __codebox_tilde_08_modPhase = this->wrap(
                    __codebox_tilde_08_modPhase + ((sr == 0. ? 0. : this->minimum(hz * __codebox_tilde_08_hitFmRatio, sr * 0.45) / sr)),
                    0,
                    1
                );//#map:_###_obj_###_:63
    
                __codebox_tilde_08_subPhase = this->wrap(__codebox_tilde_08_subPhase + ((sr == 0. ? 0. : hz * 0.5 / sr)), 0, 1);//#map:_###_obj_###_:64
    
                number modulator = rnbo_sin(
                    __codebox_tilde_08_modPhase * 6.283185307179586 + __codebox_tilde_08_modLast * ((__codebox_tilde_08_hitFeedback > 0.95 ? 0.95 : (__codebox_tilde_08_hitFeedback < 0 ? 0 : __codebox_tilde_08_hitFeedback))) * 3
                );
    
                __codebox_tilde_08_modLast = modulator;//#map:_###_obj_###_:66
    
                number carrier = rnbo_sin(
                    __codebox_tilde_08_phase * 6.283185307179586 + modulator * __codebox_tilde_08_hitFmIndex * __codebox_tilde_08_fmEnv
                );
    
                number sub = rnbo_sin(__codebox_tilde_08_subPhase * 6.283185307179586);
                number source = (carrier * 0.75 + sub * __codebox_tilde_08_hitSubLevel * 0.6) * __codebox_tilde_08_env * __codebox_tilde_08_attackEnv;
                __codebox_tilde_08_low = source * (1 - __codebox_tilde_08_lowCoef) + __codebox_tilde_08_low * __codebox_tilde_08_lowCoef;//#map:_###_obj_###_:70
                number raw = __codebox_tilde_08_low;
                auto drive = this->maximum(0.25, __codebox_tilde_08_hitDrive);
                out1[(Index)i] = ((rnbo_tanh(drive) == 0. ? 0. : rnbo_tanh(raw * drive) / rnbo_tanh(drive))) * ((__codebox_tilde_08_hitLevel > 1 ? 1 : (__codebox_tilde_08_hitLevel < 0 ? 0 : __codebox_tilde_08_hitLevel)));//#map:_###_obj_###_:73
    
                if (__codebox_tilde_08_env < 1e-7 && rnbo_abs(__codebox_tilde_08_low) < 1e-7)
                    __codebox_tilde_08_active = 0;//#map:_###_obj_###_:74;//#map:_###_obj_###_:74
            }//#map:_###_obj_###_:58
        }
    
        this->codebox_tilde_08_hitNote = __codebox_tilde_08_hitNote;
        this->codebox_tilde_08_hitDecayMs = __codebox_tilde_08_hitDecayMs;
        this->codebox_tilde_08_hitFmIndex = __codebox_tilde_08_hitFmIndex;
        this->codebox_tilde_08_hitFmRatio = __codebox_tilde_08_hitFmRatio;
        this->codebox_tilde_08_hitFmDecayMs = __codebox_tilde_08_hitFmDecayMs;
        this->codebox_tilde_08_hitFeedback = __codebox_tilde_08_hitFeedback;
        this->codebox_tilde_08_hitSubLevel = __codebox_tilde_08_hitSubLevel;
        this->codebox_tilde_08_hitBrightness = __codebox_tilde_08_hitBrightness;
        this->codebox_tilde_08_hitAttackMs = __codebox_tilde_08_hitAttackMs;
        this->codebox_tilde_08_hitBendSemitones = __codebox_tilde_08_hitBendSemitones;
        this->codebox_tilde_08_hitDrive = __codebox_tilde_08_hitDrive;
        this->codebox_tilde_08_hitLevel = __codebox_tilde_08_hitLevel;
        this->codebox_tilde_08_active = __codebox_tilde_08_active;
        this->codebox_tilde_08_env = __codebox_tilde_08_env;
        this->codebox_tilde_08_fmEnv = __codebox_tilde_08_fmEnv;
        this->codebox_tilde_08_attackEnv = __codebox_tilde_08_attackEnv;
        this->codebox_tilde_08_bendEnv = __codebox_tilde_08_bendEnv;
        this->codebox_tilde_08_phase = __codebox_tilde_08_phase;
        this->codebox_tilde_08_modPhase = __codebox_tilde_08_modPhase;
        this->codebox_tilde_08_subPhase = __codebox_tilde_08_subPhase;
        this->codebox_tilde_08_modLast = __codebox_tilde_08_modLast;
        this->codebox_tilde_08_low = __codebox_tilde_08_low;
        this->codebox_tilde_08_baseHz = __codebox_tilde_08_baseHz;
        this->codebox_tilde_08_envCoef = __codebox_tilde_08_envCoef;
        this->codebox_tilde_08_fmCoef = __codebox_tilde_08_fmCoef;
        this->codebox_tilde_08_attackCoef = __codebox_tilde_08_attackCoef;
        this->codebox_tilde_08_bendCoef = __codebox_tilde_08_bendCoef;
        this->codebox_tilde_08_lowCoef = __codebox_tilde_08_lowCoef;
    }
    
    void dspexpr_08_perform(const Sample * in1, number in2, SampleValue * out1, Index n) {
        RNBO_UNUSED(in2);
        Index i;
    
        for (i = 0; i < (Index)n; i++) {
            out1[(Index)i] = in1[(Index)i] * 1;//#map:_###_obj_###_:1
        }
    }
    
    void signalforwarder_15_perform(const SampleValue * input, SampleValue * output, Index n) {
        copySignal(output, input, n);
    }
    
    void signalforwarder_16_perform(const SampleValue * input, SampleValue * output, Index n) {
        copySignal(output, input, n);
    }
    
    void stackprotect_perform(Index n) {
        RNBO_UNUSED(n);
        auto __stackprotect_count = this->stackprotect_count;
        __stackprotect_count = 0;
        this->stackprotect_count = __stackprotect_count;
    }
    
    void ip_85_init() {
        this->ip_85_lastValue = this->ip_85_value;
    }
    
    void ip_85_fillSigBuf() {
        if ((bool)(this->ip_85_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_85_lastIndex); i < k; i++) {
                if (this->ip_85_resetCount > 0) {
                    this->ip_85_sigbuf[(Index)i] = 1;
                    this->ip_85_resetCount--;
                } else {
                    this->ip_85_sigbuf[(Index)i] = this->ip_85_lastValue;
                }
            }
    
            this->ip_85_lastIndex = k;
        }
    }
    
    void ip_85_dspsetup(bool force) {
        if ((bool)(this->ip_85_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_85_lastIndex = 0;
        this->ip_85_setupDone = true;
    }
    
    void ip_86_init() {
        this->ip_86_lastValue = this->ip_86_value;
    }
    
    void ip_86_fillSigBuf() {
        if ((bool)(this->ip_86_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_86_lastIndex); i < k; i++) {
                if (this->ip_86_resetCount > 0) {
                    this->ip_86_sigbuf[(Index)i] = 1;
                    this->ip_86_resetCount--;
                } else {
                    this->ip_86_sigbuf[(Index)i] = this->ip_86_lastValue;
                }
            }
    
            this->ip_86_lastIndex = k;
        }
    }
    
    void ip_86_dspsetup(bool force) {
        if ((bool)(this->ip_86_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_86_lastIndex = 0;
        this->ip_86_setupDone = true;
    }
    
    void ip_87_init() {
        this->ip_87_lastValue = this->ip_87_value;
    }
    
    void ip_87_fillSigBuf() {
        if ((bool)(this->ip_87_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_87_lastIndex); i < k; i++) {
                if (this->ip_87_resetCount > 0) {
                    this->ip_87_sigbuf[(Index)i] = 1;
                    this->ip_87_resetCount--;
                } else {
                    this->ip_87_sigbuf[(Index)i] = this->ip_87_lastValue;
                }
            }
    
            this->ip_87_lastIndex = k;
        }
    }
    
    void ip_87_dspsetup(bool force) {
        if ((bool)(this->ip_87_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_87_lastIndex = 0;
        this->ip_87_setupDone = true;
    }
    
    void ip_88_init() {
        this->ip_88_lastValue = this->ip_88_value;
    }
    
    void ip_88_fillSigBuf() {
        if ((bool)(this->ip_88_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_88_lastIndex); i < k; i++) {
                if (this->ip_88_resetCount > 0) {
                    this->ip_88_sigbuf[(Index)i] = 1;
                    this->ip_88_resetCount--;
                } else {
                    this->ip_88_sigbuf[(Index)i] = this->ip_88_lastValue;
                }
            }
    
            this->ip_88_lastIndex = k;
        }
    }
    
    void ip_88_dspsetup(bool force) {
        if ((bool)(this->ip_88_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_88_lastIndex = 0;
        this->ip_88_setupDone = true;
    }
    
    void ip_89_init() {
        this->ip_89_lastValue = this->ip_89_value;
    }
    
    void ip_89_fillSigBuf() {
        if ((bool)(this->ip_89_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_89_lastIndex); i < k; i++) {
                if (this->ip_89_resetCount > 0) {
                    this->ip_89_sigbuf[(Index)i] = 1;
                    this->ip_89_resetCount--;
                } else {
                    this->ip_89_sigbuf[(Index)i] = this->ip_89_lastValue;
                }
            }
    
            this->ip_89_lastIndex = k;
        }
    }
    
    void ip_89_dspsetup(bool force) {
        if ((bool)(this->ip_89_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_89_lastIndex = 0;
        this->ip_89_setupDone = true;
    }
    
    void ip_90_init() {
        this->ip_90_lastValue = this->ip_90_value;
    }
    
    void ip_90_fillSigBuf() {
        if ((bool)(this->ip_90_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_90_lastIndex); i < k; i++) {
                if (this->ip_90_resetCount > 0) {
                    this->ip_90_sigbuf[(Index)i] = 1;
                    this->ip_90_resetCount--;
                } else {
                    this->ip_90_sigbuf[(Index)i] = this->ip_90_lastValue;
                }
            }
    
            this->ip_90_lastIndex = k;
        }
    }
    
    void ip_90_dspsetup(bool force) {
        if ((bool)(this->ip_90_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_90_lastIndex = 0;
        this->ip_90_setupDone = true;
    }
    
    void ip_91_init() {
        this->ip_91_lastValue = this->ip_91_value;
    }
    
    void ip_91_fillSigBuf() {
        if ((bool)(this->ip_91_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_91_lastIndex); i < k; i++) {
                if (this->ip_91_resetCount > 0) {
                    this->ip_91_sigbuf[(Index)i] = 1;
                    this->ip_91_resetCount--;
                } else {
                    this->ip_91_sigbuf[(Index)i] = this->ip_91_lastValue;
                }
            }
    
            this->ip_91_lastIndex = k;
        }
    }
    
    void ip_91_dspsetup(bool force) {
        if ((bool)(this->ip_91_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_91_lastIndex = 0;
        this->ip_91_setupDone = true;
    }
    
    void ip_92_init() {
        this->ip_92_lastValue = this->ip_92_value;
    }
    
    void ip_92_fillSigBuf() {
        if ((bool)(this->ip_92_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_92_lastIndex); i < k; i++) {
                if (this->ip_92_resetCount > 0) {
                    this->ip_92_sigbuf[(Index)i] = 1;
                    this->ip_92_resetCount--;
                } else {
                    this->ip_92_sigbuf[(Index)i] = this->ip_92_lastValue;
                }
            }
    
            this->ip_92_lastIndex = k;
        }
    }
    
    void ip_92_dspsetup(bool force) {
        if ((bool)(this->ip_92_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_92_lastIndex = 0;
        this->ip_92_setupDone = true;
    }
    
    void ip_93_init() {
        this->ip_93_lastValue = this->ip_93_value;
    }
    
    void ip_93_fillSigBuf() {
        if ((bool)(this->ip_93_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_93_lastIndex); i < k; i++) {
                if (this->ip_93_resetCount > 0) {
                    this->ip_93_sigbuf[(Index)i] = 1;
                    this->ip_93_resetCount--;
                } else {
                    this->ip_93_sigbuf[(Index)i] = this->ip_93_lastValue;
                }
            }
    
            this->ip_93_lastIndex = k;
        }
    }
    
    void ip_93_dspsetup(bool force) {
        if ((bool)(this->ip_93_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_93_lastIndex = 0;
        this->ip_93_setupDone = true;
    }
    
    void ip_94_init() {
        this->ip_94_lastValue = this->ip_94_value;
    }
    
    void ip_94_fillSigBuf() {
        if ((bool)(this->ip_94_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_94_lastIndex); i < k; i++) {
                if (this->ip_94_resetCount > 0) {
                    this->ip_94_sigbuf[(Index)i] = 1;
                    this->ip_94_resetCount--;
                } else {
                    this->ip_94_sigbuf[(Index)i] = this->ip_94_lastValue;
                }
            }
    
            this->ip_94_lastIndex = k;
        }
    }
    
    void ip_94_dspsetup(bool force) {
        if ((bool)(this->ip_94_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_94_lastIndex = 0;
        this->ip_94_setupDone = true;
    }
    
    void ip_95_init() {
        this->ip_95_lastValue = this->ip_95_value;
    }
    
    void ip_95_fillSigBuf() {
        if ((bool)(this->ip_95_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_95_lastIndex); i < k; i++) {
                if (this->ip_95_resetCount > 0) {
                    this->ip_95_sigbuf[(Index)i] = 1;
                    this->ip_95_resetCount--;
                } else {
                    this->ip_95_sigbuf[(Index)i] = this->ip_95_lastValue;
                }
            }
    
            this->ip_95_lastIndex = k;
        }
    }
    
    void ip_95_dspsetup(bool force) {
        if ((bool)(this->ip_95_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_95_lastIndex = 0;
        this->ip_95_setupDone = true;
    }
    
    void ip_96_init() {
        this->ip_96_lastValue = this->ip_96_value;
    }
    
    void ip_96_fillSigBuf() {
        if ((bool)(this->ip_96_sigbuf)) {
            SampleIndex k = (SampleIndex)(this->sampleOffsetIntoNextAudioBuffer);
    
            if (k >= (SampleIndex)(this->vs))
                k = (SampleIndex)(this->vs) - 1;
    
            for (SampleIndex i = (SampleIndex)(this->ip_96_lastIndex); i < k; i++) {
                if (this->ip_96_resetCount > 0) {
                    this->ip_96_sigbuf[(Index)i] = 1;
                    this->ip_96_resetCount--;
                } else {
                    this->ip_96_sigbuf[(Index)i] = this->ip_96_lastValue;
                }
            }
    
            this->ip_96_lastIndex = k;
        }
    }
    
    void ip_96_dspsetup(bool force) {
        if ((bool)(this->ip_96_setupDone) && (bool)(!(bool)(force)))
            return;
    
        this->ip_96_lastIndex = 0;
        this->ip_96_setupDone = true;
    }
    
    bool stackprotect_check() {
        this->stackprotect_count++;
    
        if (this->stackprotect_count > 128) {
            console->log("STACK OVERFLOW DETECTED - stopped processing branch !");
            return true;
        }
    
        return false;
    }
    
    Index getPatcherSerial() const {
        return 0;
    }
    
    void sendParameter(ParameterIndex index, bool ignoreValue) {
        this->getPatcher()->sendParameter(index + this->parameterOffset, ignoreValue);
    }
    
    void scheduleParamInit(ParameterIndex index, Index order) {
        this->getPatcher()->scheduleParamInit(index + this->parameterOffset, order);
    }
    
    void updateTime(MillisecondTime time, EXTERNALENGINE* engine, bool inProcess = false) {
        RNBO_UNUSED(inProcess);
        RNBO_UNUSED(engine);
        this->_currentTime = time;
        auto offset = rnbo_fround(this->msToSamps(time - this->getEngine()->getCurrentTime(), this->sr));
    
        if (offset >= (SampleIndex)(this->vs))
            offset = (SampleIndex)(this->vs) - 1;
    
        if (offset < 0)
            offset = 0;
    
        this->sampleOffsetIntoNextAudioBuffer = (Index)(offset);
    }
    
    void assign_defaults()
    {
        ip_85_value = 0;
        ip_85_impulse = 0;
        ip_86_value = 0;
        ip_86_impulse = 0;
        ip_87_value = 0;
        ip_87_impulse = 0;
        ip_88_value = 0;
        ip_88_impulse = 0;
        ip_89_value = 0;
        ip_89_impulse = 0;
        ip_90_value = 0;
        ip_90_impulse = 0;
        ip_91_value = 0;
        ip_91_impulse = 0;
        ip_92_value = 0;
        ip_92_impulse = 0;
        ip_93_value = 0;
        ip_93_impulse = 0;
        ip_94_value = 0;
        ip_94_impulse = 0;
        ip_95_value = 0;
        ip_95_impulse = 0;
        ip_96_value = 0;
        ip_96_impulse = 0;
        codebox_tilde_08_in1 = 0;
        codebox_tilde_08_in2 = 0;
        codebox_tilde_08_in3 = 0;
        codebox_tilde_08_in4 = 0;
        codebox_tilde_08_in5 = 0;
        codebox_tilde_08_in6 = 0;
        codebox_tilde_08_in7 = 0;
        codebox_tilde_08_in8 = 0;
        codebox_tilde_08_in9 = 0;
        codebox_tilde_08_in10 = 0;
        codebox_tilde_08_in11 = 0;
        codebox_tilde_08_in12 = 0;
        codebox_tilde_08_in13 = 0;
        dspexpr_08_in1 = 0;
        dspexpr_08_in2 = 1;
        _currentTime = 0;
        audioProcessSampleCount = 0;
        sampleOffsetIntoNextAudioBuffer = 0;
        zeroBuffer = nullptr;
        dummyBuffer = nullptr;
        signals[0] = nullptr;
        signals[1] = nullptr;
        signals[2] = nullptr;
        signals[3] = nullptr;
        signals[4] = nullptr;
        signals[5] = nullptr;
        signals[6] = nullptr;
        signals[7] = nullptr;
        signals[8] = nullptr;
        signals[9] = nullptr;
        signals[10] = nullptr;
        signals[11] = nullptr;
        signals[12] = nullptr;
        signals[13] = nullptr;
        didAllocateSignals = 0;
        vs = 0;
        maxvs = 0;
        sr = 44100;
        invsr = 0.000022675736961451248;
        click_08_lastclick = -1;
        click_08_buf = nullptr;
        ip_85_lastIndex = 0;
        ip_85_lastValue = 0;
        ip_85_resetCount = 0;
        ip_85_sigbuf = nullptr;
        ip_85_setupDone = false;
        ip_86_lastIndex = 0;
        ip_86_lastValue = 0;
        ip_86_resetCount = 0;
        ip_86_sigbuf = nullptr;
        ip_86_setupDone = false;
        ip_87_lastIndex = 0;
        ip_87_lastValue = 0;
        ip_87_resetCount = 0;
        ip_87_sigbuf = nullptr;
        ip_87_setupDone = false;
        ip_88_lastIndex = 0;
        ip_88_lastValue = 0;
        ip_88_resetCount = 0;
        ip_88_sigbuf = nullptr;
        ip_88_setupDone = false;
        ip_89_lastIndex = 0;
        ip_89_lastValue = 0;
        ip_89_resetCount = 0;
        ip_89_sigbuf = nullptr;
        ip_89_setupDone = false;
        ip_90_lastIndex = 0;
        ip_90_lastValue = 0;
        ip_90_resetCount = 0;
        ip_90_sigbuf = nullptr;
        ip_90_setupDone = false;
        ip_91_lastIndex = 0;
        ip_91_lastValue = 0;
        ip_91_resetCount = 0;
        ip_91_sigbuf = nullptr;
        ip_91_setupDone = false;
        ip_92_lastIndex = 0;
        ip_92_lastValue = 0;
        ip_92_resetCount = 0;
        ip_92_sigbuf = nullptr;
        ip_92_setupDone = false;
        ip_93_lastIndex = 0;
        ip_93_lastValue = 0;
        ip_93_resetCount = 0;
        ip_93_sigbuf = nullptr;
        ip_93_setupDone = false;
        ip_94_lastIndex = 0;
        ip_94_lastValue = 0;
        ip_94_resetCount = 0;
        ip_94_sigbuf = nullptr;
        ip_94_setupDone = false;
        ip_95_lastIndex = 0;
        ip_95_lastValue = 0;
        ip_95_resetCount = 0;
        ip_95_sigbuf = nullptr;
        ip_95_setupDone = false;
        ip_96_lastIndex = 0;
        ip_96_lastValue = 0;
        ip_96_resetCount = 0;
        ip_96_sigbuf = nullptr;
        ip_96_setupDone = false;
        codebox_tilde_08_hitNote = 36;
        codebox_tilde_08_hitDecayMs = 550;
        codebox_tilde_08_hitFmIndex = 1.2;
        codebox_tilde_08_hitFmRatio = 1;
        codebox_tilde_08_hitFmDecayMs = 220;
        codebox_tilde_08_hitFeedback = 0.15;
        codebox_tilde_08_hitSubLevel = 0.35;
        codebox_tilde_08_hitBrightness = 0.6;
        codebox_tilde_08_hitAttackMs = 2;
        codebox_tilde_08_hitBendSemitones = 0;
        codebox_tilde_08_hitDrive = 1.4;
        codebox_tilde_08_hitLevel = 0.45;
        codebox_tilde_08_active = 0;
        codebox_tilde_08_env = 0;
        codebox_tilde_08_fmEnv = 0;
        codebox_tilde_08_attackEnv = 0;
        codebox_tilde_08_bendEnv = 0;
        codebox_tilde_08_envCoef = 0;
        codebox_tilde_08_fmCoef = 0;
        codebox_tilde_08_attackCoef = 0;
        codebox_tilde_08_bendCoef = 0;
        codebox_tilde_08_phase = 0;
        codebox_tilde_08_modPhase = 0;
        codebox_tilde_08_subPhase = 0;
        codebox_tilde_08_modLast = 0;
        codebox_tilde_08_low = 0;
        codebox_tilde_08_lowCoef = 0;
        codebox_tilde_08_baseHz = 65.406;
        stackprotect_count = 0;
        _voiceIndex = 0;
        _noteNumber = 0;
        isMuted = 1;
        parameterOffset = 0;
    }
    
    // member variables
    
        number ip_85_value;
        number ip_85_impulse;
        number ip_86_value;
        number ip_86_impulse;
        number ip_87_value;
        number ip_87_impulse;
        number ip_88_value;
        number ip_88_impulse;
        number ip_89_value;
        number ip_89_impulse;
        number ip_90_value;
        number ip_90_impulse;
        number ip_91_value;
        number ip_91_impulse;
        number ip_92_value;
        number ip_92_impulse;
        number ip_93_value;
        number ip_93_impulse;
        number ip_94_value;
        number ip_94_impulse;
        number ip_95_value;
        number ip_95_impulse;
        number ip_96_value;
        number ip_96_impulse;
        number codebox_tilde_08_in1;
        number codebox_tilde_08_in2;
        number codebox_tilde_08_in3;
        number codebox_tilde_08_in4;
        number codebox_tilde_08_in5;
        number codebox_tilde_08_in6;
        number codebox_tilde_08_in7;
        number codebox_tilde_08_in8;
        number codebox_tilde_08_in9;
        number codebox_tilde_08_in10;
        number codebox_tilde_08_in11;
        number codebox_tilde_08_in12;
        number codebox_tilde_08_in13;
        number dspexpr_08_in1;
        number dspexpr_08_in2;
        MillisecondTime _currentTime;
        UInt64 audioProcessSampleCount;
        Index sampleOffsetIntoNextAudioBuffer;
        signal zeroBuffer;
        signal dummyBuffer;
        SampleValue * signals[14];
        bool didAllocateSignals;
        Index vs;
        Index maxvs;
        number sr;
        number invsr;
        SampleIndex click_08_lastclick;
        signal click_08_buf;
        SampleIndex ip_85_lastIndex;
        number ip_85_lastValue;
        SampleIndex ip_85_resetCount;
        signal ip_85_sigbuf;
        bool ip_85_setupDone;
        SampleIndex ip_86_lastIndex;
        number ip_86_lastValue;
        SampleIndex ip_86_resetCount;
        signal ip_86_sigbuf;
        bool ip_86_setupDone;
        SampleIndex ip_87_lastIndex;
        number ip_87_lastValue;
        SampleIndex ip_87_resetCount;
        signal ip_87_sigbuf;
        bool ip_87_setupDone;
        SampleIndex ip_88_lastIndex;
        number ip_88_lastValue;
        SampleIndex ip_88_resetCount;
        signal ip_88_sigbuf;
        bool ip_88_setupDone;
        SampleIndex ip_89_lastIndex;
        number ip_89_lastValue;
        SampleIndex ip_89_resetCount;
        signal ip_89_sigbuf;
        bool ip_89_setupDone;
        SampleIndex ip_90_lastIndex;
        number ip_90_lastValue;
        SampleIndex ip_90_resetCount;
        signal ip_90_sigbuf;
        bool ip_90_setupDone;
        SampleIndex ip_91_lastIndex;
        number ip_91_lastValue;
        SampleIndex ip_91_resetCount;
        signal ip_91_sigbuf;
        bool ip_91_setupDone;
        SampleIndex ip_92_lastIndex;
        number ip_92_lastValue;
        SampleIndex ip_92_resetCount;
        signal ip_92_sigbuf;
        bool ip_92_setupDone;
        SampleIndex ip_93_lastIndex;
        number ip_93_lastValue;
        SampleIndex ip_93_resetCount;
        signal ip_93_sigbuf;
        bool ip_93_setupDone;
        SampleIndex ip_94_lastIndex;
        number ip_94_lastValue;
        SampleIndex ip_94_resetCount;
        signal ip_94_sigbuf;
        bool ip_94_setupDone;
        SampleIndex ip_95_lastIndex;
        number ip_95_lastValue;
        SampleIndex ip_95_resetCount;
        signal ip_95_sigbuf;
        bool ip_95_setupDone;
        SampleIndex ip_96_lastIndex;
        number ip_96_lastValue;
        SampleIndex ip_96_resetCount;
        signal ip_96_sigbuf;
        bool ip_96_setupDone;
        number codebox_tilde_08_hitNote;
        number codebox_tilde_08_hitDecayMs;
        number codebox_tilde_08_hitFmIndex;
        number codebox_tilde_08_hitFmRatio;
        number codebox_tilde_08_hitFmDecayMs;
        number codebox_tilde_08_hitFeedback;
        number codebox_tilde_08_hitSubLevel;
        number codebox_tilde_08_hitBrightness;
        number codebox_tilde_08_hitAttackMs;
        number codebox_tilde_08_hitBendSemitones;
        number codebox_tilde_08_hitDrive;
        number codebox_tilde_08_hitLevel;
        number codebox_tilde_08_active;
        number codebox_tilde_08_env;
        number codebox_tilde_08_fmEnv;
        number codebox_tilde_08_attackEnv;
        number codebox_tilde_08_bendEnv;
        number codebox_tilde_08_envCoef;
        number codebox_tilde_08_fmCoef;
        number codebox_tilde_08_attackCoef;
        number codebox_tilde_08_bendCoef;
        number codebox_tilde_08_phase;
        number codebox_tilde_08_modPhase;
        number codebox_tilde_08_subPhase;
        number codebox_tilde_08_modLast;
        number codebox_tilde_08_low;
        number codebox_tilde_08_lowCoef;
        number codebox_tilde_08_baseHz;
        number stackprotect_count;
        Index _voiceIndex;
        Int _noteNumber;
        Index isMuted;
        ParameterIndex parameterOffset;
        bool _isInitialized = false;
};

		
void advanceTime(EXTERNALENGINE*) {}
void advanceTime(INTERNALENGINE*) {
	_internalEngine.advanceTime(sampstoms(this->vs));
}

void processInternalEvents(MillisecondTime time) {
	_internalEngine.processEventsUntil(time);
}

void updateTime(MillisecondTime time, INTERNALENGINE*, bool inProcess = false) {
	if (time == TimeNow) time = getPatcherTime();
	processInternalEvents(inProcess ? time + sampsToMs(this->vs) : time);
	updateTime(time, (EXTERNALENGINE*)nullptr);
}

rnbomatic* operator->() {
    return this;
}
const rnbomatic* operator->() const {
    return this;
}
rnbomatic* getTopLevelPatcher() {
    return this;
}

void cancelClockEvents()
{
}

template<typename LISTTYPE = list> void listquicksort(LISTTYPE& arr, LISTTYPE& sortindices, Int l, Int h, bool ascending) {
    if (l < h) {
        Int p = (Int)(this->listpartition(arr, sortindices, l, h, ascending));
        this->listquicksort(arr, sortindices, l, p - 1, ascending);
        this->listquicksort(arr, sortindices, p + 1, h, ascending);
    }
}

template<typename LISTTYPE = list> Int listpartition(LISTTYPE& arr, LISTTYPE& sortindices, Int l, Int h, bool ascending) {
    number x = arr[(Index)h];
    Int i = (Int)(l - 1);

    for (Int j = (Int)(l); j <= h - 1; j++) {
        bool asc = (bool)((bool)(ascending) && arr[(Index)j] <= x);
        bool desc = (bool)((bool)(!(bool)(ascending)) && arr[(Index)j] >= x);

        if ((bool)(asc) || (bool)(desc)) {
            i++;
            this->listswapelements(arr, i, j);
            this->listswapelements(sortindices, i, j);
        }
    }

    i++;
    this->listswapelements(arr, i, h);
    this->listswapelements(sortindices, i, h);
    return i;
}

template<typename LISTTYPE = list> void listswapelements(LISTTYPE& arr, Int a, Int b) {
    auto tmp = arr[(Index)a];
    arr[(Index)a] = arr[(Index)b];
    arr[(Index)b] = tmp;
}

number mstosamps(MillisecondTime ms) {
    return ms * this->sr * 0.001;
}

number maximum(number x, number y) {
    return (x < y ? y : x);
}

MillisecondTime sampstoms(number samps) {
    return samps * 1000 / this->sr;
}

void param_01_value_set(number v) {
    v = this->param_01_value_constrain(v);
    this->param_01_value = v;
    this->sendParameter(0, false);

    if (this->param_01_value != this->param_01_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_01_lastValue = this->param_01_value;
    }

    this->p_01_in2_number_set(v);
}

void param_02_value_set(number v) {
    v = this->param_02_value_constrain(v);
    this->param_02_value = v;
    this->sendParameter(1, false);

    if (this->param_02_value != this->param_02_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_02_lastValue = this->param_02_value;
    }

    this->p_01_in3_number_set(v);
}

void param_03_value_set(number v) {
    v = this->param_03_value_constrain(v);
    this->param_03_value = v;
    this->sendParameter(2, false);

    if (this->param_03_value != this->param_03_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_03_lastValue = this->param_03_value;
    }

    this->p_01_in4_number_set(v);
}

void param_04_value_set(number v) {
    v = this->param_04_value_constrain(v);
    this->param_04_value = v;
    this->sendParameter(3, false);

    if (this->param_04_value != this->param_04_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_04_lastValue = this->param_04_value;
    }

    this->p_01_in5_number_set(v);
}

void param_05_value_set(number v) {
    v = this->param_05_value_constrain(v);
    this->param_05_value = v;
    this->sendParameter(4, false);

    if (this->param_05_value != this->param_05_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_05_lastValue = this->param_05_value;
    }

    this->p_01_in6_number_set(v);
}

void param_06_value_set(number v) {
    v = this->param_06_value_constrain(v);
    this->param_06_value = v;
    this->sendParameter(5, false);

    if (this->param_06_value != this->param_06_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_06_lastValue = this->param_06_value;
    }

    this->p_01_in7_number_set(v);
}

void param_07_value_set(number v) {
    v = this->param_07_value_constrain(v);
    this->param_07_value = v;
    this->sendParameter(6, false);

    if (this->param_07_value != this->param_07_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_07_lastValue = this->param_07_value;
    }

    this->p_01_in8_number_set(v);
}

void param_08_value_set(number v) {
    v = this->param_08_value_constrain(v);
    this->param_08_value = v;
    this->sendParameter(7, false);

    if (this->param_08_value != this->param_08_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_08_lastValue = this->param_08_value;
    }

    this->p_01_in9_number_set(v);
}

void param_09_value_set(number v) {
    v = this->param_09_value_constrain(v);
    this->param_09_value = v;
    this->sendParameter(8, false);

    if (this->param_09_value != this->param_09_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_09_lastValue = this->param_09_value;
    }

    this->p_01_in10_number_set(v);
}

void param_10_value_set(number v) {
    v = this->param_10_value_constrain(v);
    this->param_10_value = v;
    this->sendParameter(9, false);

    if (this->param_10_value != this->param_10_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_10_lastValue = this->param_10_value;
    }

    this->p_01_in11_number_set(v);
}

void param_11_value_set(number v) {
    v = this->param_11_value_constrain(v);
    this->param_11_value = v;
    this->sendParameter(10, false);

    if (this->param_11_value != this->param_11_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_11_lastValue = this->param_11_value;
    }

    this->p_01_in12_number_set(v);
}

void param_12_value_set(number v) {
    v = this->param_12_value_constrain(v);
    this->param_12_value = v;
    this->sendParameter(11, false);

    if (this->param_12_value != this->param_12_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_12_lastValue = this->param_12_value;
    }

    this->p_01_in13_number_set(v);
}

void param_13_value_set(number v) {
    v = this->param_13_value_constrain(v);
    this->param_13_value = v;
    this->sendParameter(12, false);

    if (this->param_13_value != this->param_13_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_13_lastValue = this->param_13_value;
    }

    this->p_02_in2_number_set(v);
}

void param_14_value_set(number v) {
    v = this->param_14_value_constrain(v);
    this->param_14_value = v;
    this->sendParameter(13, false);

    if (this->param_14_value != this->param_14_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_14_lastValue = this->param_14_value;
    }

    this->p_02_in3_number_set(v);
}

void param_15_value_set(number v) {
    v = this->param_15_value_constrain(v);
    this->param_15_value = v;
    this->sendParameter(14, false);

    if (this->param_15_value != this->param_15_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_15_lastValue = this->param_15_value;
    }

    this->p_02_in4_number_set(v);
}

void param_16_value_set(number v) {
    v = this->param_16_value_constrain(v);
    this->param_16_value = v;
    this->sendParameter(15, false);

    if (this->param_16_value != this->param_16_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_16_lastValue = this->param_16_value;
    }

    this->p_02_in5_number_set(v);
}

void param_17_value_set(number v) {
    v = this->param_17_value_constrain(v);
    this->param_17_value = v;
    this->sendParameter(16, false);

    if (this->param_17_value != this->param_17_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_17_lastValue = this->param_17_value;
    }

    this->p_02_in6_number_set(v);
}

void param_18_value_set(number v) {
    v = this->param_18_value_constrain(v);
    this->param_18_value = v;
    this->sendParameter(17, false);

    if (this->param_18_value != this->param_18_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_18_lastValue = this->param_18_value;
    }

    this->p_02_in7_number_set(v);
}

void param_19_value_set(number v) {
    v = this->param_19_value_constrain(v);
    this->param_19_value = v;
    this->sendParameter(18, false);

    if (this->param_19_value != this->param_19_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_19_lastValue = this->param_19_value;
    }

    this->p_02_in8_number_set(v);
}

void param_20_value_set(number v) {
    v = this->param_20_value_constrain(v);
    this->param_20_value = v;
    this->sendParameter(19, false);

    if (this->param_20_value != this->param_20_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_20_lastValue = this->param_20_value;
    }

    this->p_02_in9_number_set(v);
}

void param_21_value_set(number v) {
    v = this->param_21_value_constrain(v);
    this->param_21_value = v;
    this->sendParameter(20, false);

    if (this->param_21_value != this->param_21_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_21_lastValue = this->param_21_value;
    }

    this->p_02_in10_number_set(v);
}

void param_22_value_set(number v) {
    v = this->param_22_value_constrain(v);
    this->param_22_value = v;
    this->sendParameter(21, false);

    if (this->param_22_value != this->param_22_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_22_lastValue = this->param_22_value;
    }

    this->p_02_in11_number_set(v);
}

void param_23_value_set(number v) {
    v = this->param_23_value_constrain(v);
    this->param_23_value = v;
    this->sendParameter(22, false);

    if (this->param_23_value != this->param_23_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_23_lastValue = this->param_23_value;
    }

    this->p_02_in12_number_set(v);
}

void param_24_value_set(number v) {
    v = this->param_24_value_constrain(v);
    this->param_24_value = v;
    this->sendParameter(23, false);

    if (this->param_24_value != this->param_24_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_24_lastValue = this->param_24_value;
    }

    this->p_02_in13_number_set(v);
}

void param_25_value_set(number v) {
    v = this->param_25_value_constrain(v);
    this->param_25_value = v;
    this->sendParameter(24, false);

    if (this->param_25_value != this->param_25_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_25_lastValue = this->param_25_value;
    }

    this->p_03_in2_number_set(v);
}

void param_26_value_set(number v) {
    v = this->param_26_value_constrain(v);
    this->param_26_value = v;
    this->sendParameter(25, false);

    if (this->param_26_value != this->param_26_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_26_lastValue = this->param_26_value;
    }

    this->p_03_in3_number_set(v);
}

void param_27_value_set(number v) {
    v = this->param_27_value_constrain(v);
    this->param_27_value = v;
    this->sendParameter(26, false);

    if (this->param_27_value != this->param_27_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_27_lastValue = this->param_27_value;
    }

    this->p_03_in4_number_set(v);
}

void param_28_value_set(number v) {
    v = this->param_28_value_constrain(v);
    this->param_28_value = v;
    this->sendParameter(27, false);

    if (this->param_28_value != this->param_28_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_28_lastValue = this->param_28_value;
    }

    this->p_03_in5_number_set(v);
}

void param_29_value_set(number v) {
    v = this->param_29_value_constrain(v);
    this->param_29_value = v;
    this->sendParameter(28, false);

    if (this->param_29_value != this->param_29_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_29_lastValue = this->param_29_value;
    }

    this->p_03_in6_number_set(v);
}

void param_30_value_set(number v) {
    v = this->param_30_value_constrain(v);
    this->param_30_value = v;
    this->sendParameter(29, false);

    if (this->param_30_value != this->param_30_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_30_lastValue = this->param_30_value;
    }

    this->p_03_in7_number_set(v);
}

void param_31_value_set(number v) {
    v = this->param_31_value_constrain(v);
    this->param_31_value = v;
    this->sendParameter(30, false);

    if (this->param_31_value != this->param_31_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_31_lastValue = this->param_31_value;
    }

    this->p_03_in8_number_set(v);
}

void param_32_value_set(number v) {
    v = this->param_32_value_constrain(v);
    this->param_32_value = v;
    this->sendParameter(31, false);

    if (this->param_32_value != this->param_32_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_32_lastValue = this->param_32_value;
    }

    this->p_03_in9_number_set(v);
}

void param_33_value_set(number v) {
    v = this->param_33_value_constrain(v);
    this->param_33_value = v;
    this->sendParameter(32, false);

    if (this->param_33_value != this->param_33_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_33_lastValue = this->param_33_value;
    }

    this->p_03_in10_number_set(v);
}

void param_34_value_set(number v) {
    v = this->param_34_value_constrain(v);
    this->param_34_value = v;
    this->sendParameter(33, false);

    if (this->param_34_value != this->param_34_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_34_lastValue = this->param_34_value;
    }

    this->p_03_in11_number_set(v);
}

void param_35_value_set(number v) {
    v = this->param_35_value_constrain(v);
    this->param_35_value = v;
    this->sendParameter(34, false);

    if (this->param_35_value != this->param_35_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_35_lastValue = this->param_35_value;
    }

    this->p_03_in12_number_set(v);
}

void param_36_value_set(number v) {
    v = this->param_36_value_constrain(v);
    this->param_36_value = v;
    this->sendParameter(35, false);

    if (this->param_36_value != this->param_36_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_36_lastValue = this->param_36_value;
    }

    this->p_03_in13_number_set(v);
}

void param_37_value_set(number v) {
    v = this->param_37_value_constrain(v);
    this->param_37_value = v;
    this->sendParameter(36, false);

    if (this->param_37_value != this->param_37_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_37_lastValue = this->param_37_value;
    }

    this->p_04_in2_number_set(v);
}

void param_38_value_set(number v) {
    v = this->param_38_value_constrain(v);
    this->param_38_value = v;
    this->sendParameter(37, false);

    if (this->param_38_value != this->param_38_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_38_lastValue = this->param_38_value;
    }

    this->p_04_in3_number_set(v);
}

void param_39_value_set(number v) {
    v = this->param_39_value_constrain(v);
    this->param_39_value = v;
    this->sendParameter(38, false);

    if (this->param_39_value != this->param_39_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_39_lastValue = this->param_39_value;
    }

    this->p_04_in4_number_set(v);
}

void param_40_value_set(number v) {
    v = this->param_40_value_constrain(v);
    this->param_40_value = v;
    this->sendParameter(39, false);

    if (this->param_40_value != this->param_40_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_40_lastValue = this->param_40_value;
    }

    this->p_04_in5_number_set(v);
}

void param_41_value_set(number v) {
    v = this->param_41_value_constrain(v);
    this->param_41_value = v;
    this->sendParameter(40, false);

    if (this->param_41_value != this->param_41_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_41_lastValue = this->param_41_value;
    }

    this->p_04_in6_number_set(v);
}

void param_42_value_set(number v) {
    v = this->param_42_value_constrain(v);
    this->param_42_value = v;
    this->sendParameter(41, false);

    if (this->param_42_value != this->param_42_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_42_lastValue = this->param_42_value;
    }

    this->p_04_in7_number_set(v);
}

void param_43_value_set(number v) {
    v = this->param_43_value_constrain(v);
    this->param_43_value = v;
    this->sendParameter(42, false);

    if (this->param_43_value != this->param_43_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_43_lastValue = this->param_43_value;
    }

    this->p_04_in8_number_set(v);
}

void param_44_value_set(number v) {
    v = this->param_44_value_constrain(v);
    this->param_44_value = v;
    this->sendParameter(43, false);

    if (this->param_44_value != this->param_44_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_44_lastValue = this->param_44_value;
    }

    this->p_04_in9_number_set(v);
}

void param_45_value_set(number v) {
    v = this->param_45_value_constrain(v);
    this->param_45_value = v;
    this->sendParameter(44, false);

    if (this->param_45_value != this->param_45_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_45_lastValue = this->param_45_value;
    }

    this->p_04_in10_number_set(v);
}

void param_46_value_set(number v) {
    v = this->param_46_value_constrain(v);
    this->param_46_value = v;
    this->sendParameter(45, false);

    if (this->param_46_value != this->param_46_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_46_lastValue = this->param_46_value;
    }

    this->p_04_in11_number_set(v);
}

void param_47_value_set(number v) {
    v = this->param_47_value_constrain(v);
    this->param_47_value = v;
    this->sendParameter(46, false);

    if (this->param_47_value != this->param_47_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_47_lastValue = this->param_47_value;
    }

    this->p_04_in12_number_set(v);
}

void param_48_value_set(number v) {
    v = this->param_48_value_constrain(v);
    this->param_48_value = v;
    this->sendParameter(47, false);

    if (this->param_48_value != this->param_48_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_48_lastValue = this->param_48_value;
    }

    this->p_04_in13_number_set(v);
}

void param_49_value_set(number v) {
    v = this->param_49_value_constrain(v);
    this->param_49_value = v;
    this->sendParameter(48, false);

    if (this->param_49_value != this->param_49_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_49_lastValue = this->param_49_value;
    }

    this->p_05_in2_number_set(v);
}

void param_50_value_set(number v) {
    v = this->param_50_value_constrain(v);
    this->param_50_value = v;
    this->sendParameter(49, false);

    if (this->param_50_value != this->param_50_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_50_lastValue = this->param_50_value;
    }

    this->p_05_in5_number_set(v);
}

void param_51_value_set(number v) {
    v = this->param_51_value_constrain(v);
    this->param_51_value = v;
    this->sendParameter(50, false);

    if (this->param_51_value != this->param_51_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_51_lastValue = this->param_51_value;
    }

    this->p_05_in6_number_set(v);
}

void param_52_value_set(number v) {
    v = this->param_52_value_constrain(v);
    this->param_52_value = v;
    this->sendParameter(51, false);

    if (this->param_52_value != this->param_52_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_52_lastValue = this->param_52_value;
    }

    this->p_05_in3_number_set(v);
}

void param_53_value_set(number v) {
    v = this->param_53_value_constrain(v);
    this->param_53_value = v;
    this->sendParameter(52, false);

    if (this->param_53_value != this->param_53_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_53_lastValue = this->param_53_value;
    }

    this->p_05_in4_number_set(v);
}

void param_54_value_set(number v) {
    v = this->param_54_value_constrain(v);
    this->param_54_value = v;
    this->sendParameter(53, false);

    if (this->param_54_value != this->param_54_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_54_lastValue = this->param_54_value;
    }

    this->p_05_in7_number_set(v);
}

void param_55_value_set(number v) {
    v = this->param_55_value_constrain(v);
    this->param_55_value = v;
    this->sendParameter(54, false);

    if (this->param_55_value != this->param_55_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_55_lastValue = this->param_55_value;
    }

    this->p_05_in10_number_set(v);
}

void param_56_value_set(number v) {
    v = this->param_56_value_constrain(v);
    this->param_56_value = v;
    this->sendParameter(55, false);

    if (this->param_56_value != this->param_56_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_56_lastValue = this->param_56_value;
    }

    this->p_05_in11_number_set(v);
}

void param_57_value_set(number v) {
    v = this->param_57_value_constrain(v);
    this->param_57_value = v;
    this->sendParameter(56, false);

    if (this->param_57_value != this->param_57_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_57_lastValue = this->param_57_value;
    }

    this->p_05_in12_number_set(v);
}

void param_58_value_set(number v) {
    v = this->param_58_value_constrain(v);
    this->param_58_value = v;
    this->sendParameter(57, false);

    if (this->param_58_value != this->param_58_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_58_lastValue = this->param_58_value;
    }

    this->p_05_in8_number_set(v);
}

void param_59_value_set(number v) {
    v = this->param_59_value_constrain(v);
    this->param_59_value = v;
    this->sendParameter(58, false);

    if (this->param_59_value != this->param_59_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_59_lastValue = this->param_59_value;
    }

    this->p_05_in9_number_set(v);
}

void param_60_value_set(number v) {
    v = this->param_60_value_constrain(v);
    this->param_60_value = v;
    this->sendParameter(59, false);

    if (this->param_60_value != this->param_60_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_60_lastValue = this->param_60_value;
    }

    this->p_05_in13_number_set(v);
}

void param_61_value_set(number v) {
    v = this->param_61_value_constrain(v);
    this->param_61_value = v;
    this->sendParameter(60, false);

    if (this->param_61_value != this->param_61_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_61_lastValue = this->param_61_value;
    }

    this->p_06_in2_number_set(v);
}

void param_62_value_set(number v) {
    v = this->param_62_value_constrain(v);
    this->param_62_value = v;
    this->sendParameter(61, false);

    if (this->param_62_value != this->param_62_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_62_lastValue = this->param_62_value;
    }

    this->p_06_in5_number_set(v);
}

void param_63_value_set(number v) {
    v = this->param_63_value_constrain(v);
    this->param_63_value = v;
    this->sendParameter(62, false);

    if (this->param_63_value != this->param_63_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_63_lastValue = this->param_63_value;
    }

    this->p_06_in6_number_set(v);
}

void param_64_value_set(number v) {
    v = this->param_64_value_constrain(v);
    this->param_64_value = v;
    this->sendParameter(63, false);

    if (this->param_64_value != this->param_64_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_64_lastValue = this->param_64_value;
    }

    this->p_06_in3_number_set(v);
}

void param_65_value_set(number v) {
    v = this->param_65_value_constrain(v);
    this->param_65_value = v;
    this->sendParameter(64, false);

    if (this->param_65_value != this->param_65_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_65_lastValue = this->param_65_value;
    }

    this->p_06_in4_number_set(v);
}

void param_66_value_set(number v) {
    v = this->param_66_value_constrain(v);
    this->param_66_value = v;
    this->sendParameter(65, false);

    if (this->param_66_value != this->param_66_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_66_lastValue = this->param_66_value;
    }

    this->p_06_in7_number_set(v);
}

void param_67_value_set(number v) {
    v = this->param_67_value_constrain(v);
    this->param_67_value = v;
    this->sendParameter(66, false);

    if (this->param_67_value != this->param_67_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_67_lastValue = this->param_67_value;
    }

    this->p_06_in10_number_set(v);
}

void param_68_value_set(number v) {
    v = this->param_68_value_constrain(v);
    this->param_68_value = v;
    this->sendParameter(67, false);

    if (this->param_68_value != this->param_68_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_68_lastValue = this->param_68_value;
    }

    this->p_06_in11_number_set(v);
}

void param_69_value_set(number v) {
    v = this->param_69_value_constrain(v);
    this->param_69_value = v;
    this->sendParameter(68, false);

    if (this->param_69_value != this->param_69_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_69_lastValue = this->param_69_value;
    }

    this->p_06_in12_number_set(v);
}

void param_70_value_set(number v) {
    v = this->param_70_value_constrain(v);
    this->param_70_value = v;
    this->sendParameter(69, false);

    if (this->param_70_value != this->param_70_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_70_lastValue = this->param_70_value;
    }

    this->p_06_in8_number_set(v);
}

void param_71_value_set(number v) {
    v = this->param_71_value_constrain(v);
    this->param_71_value = v;
    this->sendParameter(70, false);

    if (this->param_71_value != this->param_71_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_71_lastValue = this->param_71_value;
    }

    this->p_06_in9_number_set(v);
}

void param_72_value_set(number v) {
    v = this->param_72_value_constrain(v);
    this->param_72_value = v;
    this->sendParameter(71, false);

    if (this->param_72_value != this->param_72_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_72_lastValue = this->param_72_value;
    }

    this->p_06_in13_number_set(v);
}

void param_73_value_set(number v) {
    v = this->param_73_value_constrain(v);
    this->param_73_value = v;
    this->sendParameter(72, false);

    if (this->param_73_value != this->param_73_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_73_lastValue = this->param_73_value;
    }

    this->p_07_in2_number_set(v);
}

void param_74_value_set(number v) {
    v = this->param_74_value_constrain(v);
    this->param_74_value = v;
    this->sendParameter(73, false);

    if (this->param_74_value != this->param_74_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_74_lastValue = this->param_74_value;
    }

    this->p_07_in5_number_set(v);
}

void param_75_value_set(number v) {
    v = this->param_75_value_constrain(v);
    this->param_75_value = v;
    this->sendParameter(74, false);

    if (this->param_75_value != this->param_75_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_75_lastValue = this->param_75_value;
    }

    this->p_07_in6_number_set(v);
}

void param_76_value_set(number v) {
    v = this->param_76_value_constrain(v);
    this->param_76_value = v;
    this->sendParameter(75, false);

    if (this->param_76_value != this->param_76_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_76_lastValue = this->param_76_value;
    }

    this->p_07_in3_number_set(v);
}

void param_77_value_set(number v) {
    v = this->param_77_value_constrain(v);
    this->param_77_value = v;
    this->sendParameter(76, false);

    if (this->param_77_value != this->param_77_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_77_lastValue = this->param_77_value;
    }

    this->p_07_in4_number_set(v);
}

void param_78_value_set(number v) {
    v = this->param_78_value_constrain(v);
    this->param_78_value = v;
    this->sendParameter(77, false);

    if (this->param_78_value != this->param_78_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_78_lastValue = this->param_78_value;
    }

    this->p_07_in7_number_set(v);
}

void param_79_value_set(number v) {
    v = this->param_79_value_constrain(v);
    this->param_79_value = v;
    this->sendParameter(78, false);

    if (this->param_79_value != this->param_79_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_79_lastValue = this->param_79_value;
    }

    this->p_07_in10_number_set(v);
}

void param_80_value_set(number v) {
    v = this->param_80_value_constrain(v);
    this->param_80_value = v;
    this->sendParameter(79, false);

    if (this->param_80_value != this->param_80_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_80_lastValue = this->param_80_value;
    }

    this->p_07_in11_number_set(v);
}

void param_81_value_set(number v) {
    v = this->param_81_value_constrain(v);
    this->param_81_value = v;
    this->sendParameter(80, false);

    if (this->param_81_value != this->param_81_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_81_lastValue = this->param_81_value;
    }

    this->p_07_in12_number_set(v);
}

void param_82_value_set(number v) {
    v = this->param_82_value_constrain(v);
    this->param_82_value = v;
    this->sendParameter(81, false);

    if (this->param_82_value != this->param_82_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_82_lastValue = this->param_82_value;
    }

    this->p_07_in8_number_set(v);
}

void param_83_value_set(number v) {
    v = this->param_83_value_constrain(v);
    this->param_83_value = v;
    this->sendParameter(82, false);

    if (this->param_83_value != this->param_83_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_83_lastValue = this->param_83_value;
    }

    this->p_07_in9_number_set(v);
}

void param_84_value_set(number v) {
    v = this->param_84_value_constrain(v);
    this->param_84_value = v;
    this->sendParameter(83, false);

    if (this->param_84_value != this->param_84_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_84_lastValue = this->param_84_value;
    }

    this->p_07_in13_number_set(v);
}

void param_85_value_set(number v) {
    v = this->param_85_value_constrain(v);
    this->param_85_value = v;
    this->sendParameter(84, false);

    if (this->param_85_value != this->param_85_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_85_lastValue = this->param_85_value;
    }

    this->p_08_in2_number_set(v);
}

void param_86_value_set(number v) {
    v = this->param_86_value_constrain(v);
    this->param_86_value = v;
    this->sendParameter(85, false);

    if (this->param_86_value != this->param_86_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_86_lastValue = this->param_86_value;
    }

    this->p_08_in5_number_set(v);
}

void param_87_value_set(number v) {
    v = this->param_87_value_constrain(v);
    this->param_87_value = v;
    this->sendParameter(86, false);

    if (this->param_87_value != this->param_87_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_87_lastValue = this->param_87_value;
    }

    this->p_08_in6_number_set(v);
}

void param_88_value_set(number v) {
    v = this->param_88_value_constrain(v);
    this->param_88_value = v;
    this->sendParameter(87, false);

    if (this->param_88_value != this->param_88_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_88_lastValue = this->param_88_value;
    }

    this->p_08_in3_number_set(v);
}

void param_89_value_set(number v) {
    v = this->param_89_value_constrain(v);
    this->param_89_value = v;
    this->sendParameter(88, false);

    if (this->param_89_value != this->param_89_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_89_lastValue = this->param_89_value;
    }

    this->p_08_in4_number_set(v);
}

void param_90_value_set(number v) {
    v = this->param_90_value_constrain(v);
    this->param_90_value = v;
    this->sendParameter(89, false);

    if (this->param_90_value != this->param_90_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_90_lastValue = this->param_90_value;
    }

    this->p_08_in7_number_set(v);
}

void param_91_value_set(number v) {
    v = this->param_91_value_constrain(v);
    this->param_91_value = v;
    this->sendParameter(90, false);

    if (this->param_91_value != this->param_91_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_91_lastValue = this->param_91_value;
    }

    this->p_08_in10_number_set(v);
}

void param_92_value_set(number v) {
    v = this->param_92_value_constrain(v);
    this->param_92_value = v;
    this->sendParameter(91, false);

    if (this->param_92_value != this->param_92_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_92_lastValue = this->param_92_value;
    }

    this->p_08_in11_number_set(v);
}

void param_93_value_set(number v) {
    v = this->param_93_value_constrain(v);
    this->param_93_value = v;
    this->sendParameter(92, false);

    if (this->param_93_value != this->param_93_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_93_lastValue = this->param_93_value;
    }

    this->p_08_in12_number_set(v);
}

void param_94_value_set(number v) {
    v = this->param_94_value_constrain(v);
    this->param_94_value = v;
    this->sendParameter(93, false);

    if (this->param_94_value != this->param_94_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_94_lastValue = this->param_94_value;
    }

    this->p_08_in8_number_set(v);
}

void param_95_value_set(number v) {
    v = this->param_95_value_constrain(v);
    this->param_95_value = v;
    this->sendParameter(94, false);

    if (this->param_95_value != this->param_95_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_95_lastValue = this->param_95_value;
    }

    this->p_08_in9_number_set(v);
}

void param_96_value_set(number v) {
    v = this->param_96_value_constrain(v);
    this->param_96_value = v;
    this->sendParameter(95, false);

    if (this->param_96_value != this->param_96_lastValue) {
        {
            this->getEngine()->presetTouched();
        }

        this->param_96_lastValue = this->param_96_value;
    }

    this->p_08_in13_number_set(v);
}

MillisecondTime getPatcherTime() const {
    return this->_currentTime;
}

void inport_01_value_bang_bang() {
    this->inport_01_out_bang_bang();
}

void inport_01_value_number_set(number v) {
    this->inport_01_out_number_set(v);
}

template<typename LISTTYPE> void inport_01_value_list_set(const LISTTYPE& v) {
    this->inport_01_out_list_set(v);
}

void inport_02_value_bang_bang() {
    this->inport_02_out_bang_bang();
}

void inport_02_value_number_set(number v) {
    this->inport_02_out_number_set(v);
}

template<typename LISTTYPE> void inport_02_value_list_set(const LISTTYPE& v) {
    this->inport_02_out_list_set(v);
}

void inport_03_value_bang_bang() {
    this->inport_03_out_bang_bang();
}

void inport_03_value_number_set(number v) {
    this->inport_03_out_number_set(v);
}

template<typename LISTTYPE> void inport_03_value_list_set(const LISTTYPE& v) {
    this->inport_03_out_list_set(v);
}

void inport_04_value_bang_bang() {
    this->inport_04_out_bang_bang();
}

void inport_04_value_number_set(number v) {
    this->inport_04_out_number_set(v);
}

template<typename LISTTYPE> void inport_04_value_list_set(const LISTTYPE& v) {
    this->inport_04_out_list_set(v);
}

void inport_05_value_bang_bang() {
    this->inport_05_out_bang_bang();
}

void inport_05_value_number_set(number v) {
    this->inport_05_out_number_set(v);
}

template<typename LISTTYPE> void inport_05_value_list_set(const LISTTYPE& v) {
    this->inport_05_out_list_set(v);
}

void inport_06_value_bang_bang() {
    this->inport_06_out_bang_bang();
}

void inport_06_value_number_set(number v) {
    this->inport_06_out_number_set(v);
}

template<typename LISTTYPE> void inport_06_value_list_set(const LISTTYPE& v) {
    this->inport_06_out_list_set(v);
}

void inport_07_value_bang_bang() {
    this->inport_07_out_bang_bang();
}

void inport_07_value_number_set(number v) {
    this->inport_07_out_number_set(v);
}

template<typename LISTTYPE> void inport_07_value_list_set(const LISTTYPE& v) {
    this->inport_07_out_list_set(v);
}

void inport_08_value_bang_bang() {
    this->inport_08_out_bang_bang();
}

void inport_08_value_number_set(number v) {
    this->inport_08_out_number_set(v);
}

template<typename LISTTYPE> void inport_08_value_list_set(const LISTTYPE& v) {
    this->inport_08_out_list_set(v);
}

void deallocateSignals() {
    Index i;
    this->globaltransport_tempo = freeSignal(this->globaltransport_tempo);
    this->globaltransport_state = freeSignal(this->globaltransport_state);
    this->zeroBuffer = freeSignal(this->zeroBuffer);
    this->dummyBuffer = freeSignal(this->dummyBuffer);
}

Index getMaxBlockSize() const {
    return this->maxvs;
}

number getSampleRate() const {
    return this->sr;
}

bool hasFixedVectorSize() const {
    return false;
}

void setProbingTarget(MessageTag ) {}

void fillDataRef(DataRefIndex , DataRef& ) {}

void allocateDataRefs() {
    this->p_01->allocateDataRefs();
    this->p_02->allocateDataRefs();
    this->p_03->allocateDataRefs();
    this->p_04->allocateDataRefs();
    this->p_05->allocateDataRefs();
    this->p_06->allocateDataRefs();
    this->p_07->allocateDataRefs();
    this->p_08->allocateDataRefs();
}

void initializeObjects() {
    this->p_01->initializeObjects();
    this->p_02->initializeObjects();
    this->p_03->initializeObjects();
    this->p_04->initializeObjects();
    this->p_05->initializeObjects();
    this->p_06->initializeObjects();
    this->p_07->initializeObjects();
    this->p_08->initializeObjects();
}

Index getIsMuted()  {
    return this->isMuted;
}

void setIsMuted(Index v)  {
    this->isMuted = v;
}

void onSampleRateChanged(double ) {}

void extractState(PatcherStateInterface& ) {}

void applyState() {

    this->p_01->setEngineAndPatcher(this->getEngine(), this);
    this->p_01->initialize();
    this->p_01->setParameterOffset(this->getParameterOffset(this->p_01));

    this->p_02->setEngineAndPatcher(this->getEngine(), this);
    this->p_02->initialize();
    this->p_02->setParameterOffset(this->getParameterOffset(this->p_02));

    this->p_03->setEngineAndPatcher(this->getEngine(), this);
    this->p_03->initialize();
    this->p_03->setParameterOffset(this->getParameterOffset(this->p_03));

    this->p_04->setEngineAndPatcher(this->getEngine(), this);
    this->p_04->initialize();
    this->p_04->setParameterOffset(this->getParameterOffset(this->p_04));

    this->p_05->setEngineAndPatcher(this->getEngine(), this);
    this->p_05->initialize();
    this->p_05->setParameterOffset(this->getParameterOffset(this->p_05));

    this->p_06->setEngineAndPatcher(this->getEngine(), this);
    this->p_06->initialize();
    this->p_06->setParameterOffset(this->getParameterOffset(this->p_06));

    this->p_07->setEngineAndPatcher(this->getEngine(), this);
    this->p_07->initialize();
    this->p_07->setParameterOffset(this->getParameterOffset(this->p_07));

    this->p_08->setEngineAndPatcher(this->getEngine(), this);
    this->p_08->initialize();
    this->p_08->setParameterOffset(this->getParameterOffset(this->p_08));
}

ParameterIndex getParameterOffset(BaseInterface& subpatcher) const {
    if (addressOf(subpatcher) == addressOf(this->p_01))
        return 96;

    if (addressOf(subpatcher) == addressOf(this->p_02))
        return 96 + this->p_01->getNumParameters();

    if (addressOf(subpatcher) == addressOf(this->p_03))
        return 96 + this->p_01->getNumParameters() + this->p_02->getNumParameters();

    if (addressOf(subpatcher) == addressOf(this->p_04))
        return 96 + this->p_01->getNumParameters() + this->p_02->getNumParameters() + this->p_03->getNumParameters();

    if (addressOf(subpatcher) == addressOf(this->p_05))
        return 96 + this->p_01->getNumParameters() + this->p_02->getNumParameters() + this->p_03->getNumParameters() + this->p_04->getNumParameters();

    if (addressOf(subpatcher) == addressOf(this->p_06))
        return 96 + this->p_01->getNumParameters() + this->p_02->getNumParameters() + this->p_03->getNumParameters() + this->p_04->getNumParameters() + this->p_05->getNumParameters();

    if (addressOf(subpatcher) == addressOf(this->p_07))
        return 96 + this->p_01->getNumParameters() + this->p_02->getNumParameters() + this->p_03->getNumParameters() + this->p_04->getNumParameters() + this->p_05->getNumParameters() + this->p_06->getNumParameters();

    if (addressOf(subpatcher) == addressOf(this->p_08))
        return 96 + this->p_01->getNumParameters() + this->p_02->getNumParameters() + this->p_03->getNumParameters() + this->p_04->getNumParameters() + this->p_05->getNumParameters() + this->p_06->getNumParameters() + this->p_07->getNumParameters();

    return 0;
}

void processClockEvent(MillisecondTime , ClockId , bool , ParameterValue ) {}

void processOutletAtCurrentTime(EngineLink* , OutletIndex , ParameterValue ) {}

void processOutletEvent(
    EngineLink* sender,
    OutletIndex index,
    ParameterValue value,
    MillisecondTime time
) {
    this->updateTime(time, (ENGINE*)nullptr);
    this->processOutletAtCurrentTime(sender, index, value);
}

void sendOutlet(OutletIndex index, ParameterValue value) {
    this->getEngine()->sendOutlet(this, index, value);
}

void startup() {
    this->updateTime(this->getEngine()->getCurrentTime(), (ENGINE*)nullptr);
    this->p_01->startup();
    this->p_02->startup();
    this->p_03->startup();
    this->p_04->startup();
    this->p_05->startup();
    this->p_06->startup();
    this->p_07->startup();
    this->p_08->startup();

    {
        this->scheduleParamInit(0, 0);
    }

    {
        this->scheduleParamInit(1, 0);
    }

    {
        this->scheduleParamInit(2, 0);
    }

    {
        this->scheduleParamInit(3, 0);
    }

    {
        this->scheduleParamInit(4, 0);
    }

    {
        this->scheduleParamInit(5, 0);
    }

    {
        this->scheduleParamInit(6, 0);
    }

    {
        this->scheduleParamInit(7, 0);
    }

    {
        this->scheduleParamInit(8, 0);
    }

    {
        this->scheduleParamInit(9, 0);
    }

    {
        this->scheduleParamInit(10, 0);
    }

    {
        this->scheduleParamInit(11, 0);
    }

    {
        this->scheduleParamInit(12, 0);
    }

    {
        this->scheduleParamInit(13, 0);
    }

    {
        this->scheduleParamInit(14, 0);
    }

    {
        this->scheduleParamInit(15, 0);
    }

    {
        this->scheduleParamInit(16, 0);
    }

    {
        this->scheduleParamInit(17, 0);
    }

    {
        this->scheduleParamInit(18, 0);
    }

    {
        this->scheduleParamInit(19, 0);
    }

    {
        this->scheduleParamInit(20, 0);
    }

    {
        this->scheduleParamInit(21, 0);
    }

    {
        this->scheduleParamInit(22, 0);
    }

    {
        this->scheduleParamInit(23, 0);
    }

    {
        this->scheduleParamInit(24, 0);
    }

    {
        this->scheduleParamInit(25, 0);
    }

    {
        this->scheduleParamInit(26, 0);
    }

    {
        this->scheduleParamInit(27, 0);
    }

    {
        this->scheduleParamInit(28, 0);
    }

    {
        this->scheduleParamInit(29, 0);
    }

    {
        this->scheduleParamInit(30, 0);
    }

    {
        this->scheduleParamInit(31, 0);
    }

    {
        this->scheduleParamInit(32, 0);
    }

    {
        this->scheduleParamInit(33, 0);
    }

    {
        this->scheduleParamInit(34, 0);
    }

    {
        this->scheduleParamInit(35, 0);
    }

    {
        this->scheduleParamInit(36, 0);
    }

    {
        this->scheduleParamInit(37, 0);
    }

    {
        this->scheduleParamInit(38, 0);
    }

    {
        this->scheduleParamInit(39, 0);
    }

    {
        this->scheduleParamInit(40, 0);
    }

    {
        this->scheduleParamInit(41, 0);
    }

    {
        this->scheduleParamInit(42, 0);
    }

    {
        this->scheduleParamInit(43, 0);
    }

    {
        this->scheduleParamInit(44, 0);
    }

    {
        this->scheduleParamInit(45, 0);
    }

    {
        this->scheduleParamInit(46, 0);
    }

    {
        this->scheduleParamInit(47, 0);
    }

    {
        this->scheduleParamInit(48, 0);
    }

    {
        this->scheduleParamInit(49, 0);
    }

    {
        this->scheduleParamInit(50, 0);
    }

    {
        this->scheduleParamInit(51, 0);
    }

    {
        this->scheduleParamInit(52, 0);
    }

    {
        this->scheduleParamInit(53, 0);
    }

    {
        this->scheduleParamInit(54, 0);
    }

    {
        this->scheduleParamInit(55, 0);
    }

    {
        this->scheduleParamInit(56, 0);
    }

    {
        this->scheduleParamInit(57, 0);
    }

    {
        this->scheduleParamInit(58, 0);
    }

    {
        this->scheduleParamInit(59, 0);
    }

    {
        this->scheduleParamInit(60, 0);
    }

    {
        this->scheduleParamInit(61, 0);
    }

    {
        this->scheduleParamInit(62, 0);
    }

    {
        this->scheduleParamInit(63, 0);
    }

    {
        this->scheduleParamInit(64, 0);
    }

    {
        this->scheduleParamInit(65, 0);
    }

    {
        this->scheduleParamInit(66, 0);
    }

    {
        this->scheduleParamInit(67, 0);
    }

    {
        this->scheduleParamInit(68, 0);
    }

    {
        this->scheduleParamInit(69, 0);
    }

    {
        this->scheduleParamInit(70, 0);
    }

    {
        this->scheduleParamInit(71, 0);
    }

    {
        this->scheduleParamInit(72, 0);
    }

    {
        this->scheduleParamInit(73, 0);
    }

    {
        this->scheduleParamInit(74, 0);
    }

    {
        this->scheduleParamInit(75, 0);
    }

    {
        this->scheduleParamInit(76, 0);
    }

    {
        this->scheduleParamInit(77, 0);
    }

    {
        this->scheduleParamInit(78, 0);
    }

    {
        this->scheduleParamInit(79, 0);
    }

    {
        this->scheduleParamInit(80, 0);
    }

    {
        this->scheduleParamInit(81, 0);
    }

    {
        this->scheduleParamInit(82, 0);
    }

    {
        this->scheduleParamInit(83, 0);
    }

    {
        this->scheduleParamInit(84, 0);
    }

    {
        this->scheduleParamInit(85, 0);
    }

    {
        this->scheduleParamInit(86, 0);
    }

    {
        this->scheduleParamInit(87, 0);
    }

    {
        this->scheduleParamInit(88, 0);
    }

    {
        this->scheduleParamInit(89, 0);
    }

    {
        this->scheduleParamInit(90, 0);
    }

    {
        this->scheduleParamInit(91, 0);
    }

    {
        this->scheduleParamInit(92, 0);
    }

    {
        this->scheduleParamInit(93, 0);
    }

    {
        this->scheduleParamInit(94, 0);
    }

    {
        this->scheduleParamInit(95, 0);
    }

    this->processParamInitEvents();
}

number param_01_value_constrain(number v) const {
    v = (v > 2000 ? 2000 : (v < 10 ? 10 : v));
    return v;
}

void p_01_in2_number_set(number v) {
    this->p_01->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_01->eventinlet_02_out1_number_set(v);
}

number param_02_value_constrain(number v) const {
    v = (v > 600 ? 600 : (v < 0 ? 0 : v));
    return v;
}

void p_01_in3_number_set(number v) {
    this->p_01->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_01->eventinlet_03_out1_number_set(v);
}

number param_03_value_constrain(number v) const {
    v = (v > 300 ? 300 : (v < 1 ? 1 : v));
    return v;
}

void p_01_in4_number_set(number v) {
    this->p_01->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_01->eventinlet_04_out1_number_set(v);
}

number param_04_value_constrain(number v) const {
    v = (v > 30000 ? 30000 : (v < 1 ? 1 : v));
    return v;
}

void p_01_in5_number_set(number v) {
    this->p_01->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_01->eventinlet_05_out1_number_set(v);
}

number param_05_value_constrain(number v) const {
    v = (v > 32 ? 32 : (v < 0 ? 0 : v));
    return v;
}

void p_01_in6_number_set(number v) {
    this->p_01->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_01->eventinlet_06_out1_number_set(v);
}

number param_06_value_constrain(number v) const {
    v = (v > 8 ? 8 : (v < 0.125 ? 0.125 : v));
    return v;
}

void p_01_in7_number_set(number v) {
    this->p_01->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_01->eventinlet_07_out1_number_set(v);
}

number param_07_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_01_in8_number_set(number v) {
    this->p_01->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_01->eventinlet_08_out1_number_set(v);
}

number param_08_value_constrain(number v) const {
    v = (v > 400 ? 400 : (v < 25 ? 25 : v));
    return v;
}

void p_01_in9_number_set(number v) {
    this->p_01->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_01->eventinlet_09_out1_number_set(v);
}

number param_09_value_constrain(number v) const {
    v = (v > 24 ? 24 : (v < 0.5 ? 0.5 : v));
    return v;
}

void p_01_in10_number_set(number v) {
    this->p_01->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_01->eventinlet_10_out1_number_set(v);
}

number param_10_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_01_in11_number_set(number v) {
    this->p_01->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_01->eventinlet_11_out1_number_set(v);
}

number param_11_value_constrain(number v) const {
    v = (v > 8 ? 8 : (v < 0.25 ? 0.25 : v));
    return v;
}

void p_01_in12_number_set(number v) {
    this->p_01->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_01->eventinlet_12_out1_number_set(v);
}

number param_12_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_01_in13_number_set(number v) {
    this->p_01->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_01->eventinlet_13_out1_number_set(v);
}

number param_13_value_constrain(number v) const {
    v = (v > 1200 ? 1200 : (v < 40 ? 40 : v));
    return v;
}

void p_02_in2_number_set(number v) {
    this->p_02->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_02->eventinlet_15_out1_number_set(v);
}

number param_14_value_constrain(number v) const {
    v = (v > 1200 ? 1200 : (v < 0 ? 0 : v));
    return v;
}

void p_02_in3_number_set(number v) {
    this->p_02->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_02->eventinlet_16_out1_number_set(v);
}

number param_15_value_constrain(number v) const {
    v = (v > 10000 ? 10000 : (v < 5 ? 5 : v));
    return v;
}

void p_02_in4_number_set(number v) {
    this->p_02->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_02->eventinlet_17_out1_number_set(v);
}

number param_16_value_constrain(number v) const {
    v = (v > 5000 ? 5000 : (v < 5 ? 5 : v));
    return v;
}

void p_02_in5_number_set(number v) {
    this->p_02->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_02->eventinlet_18_out1_number_set(v);
}

number param_17_value_constrain(number v) const {
    v = (v > 16 ? 16 : (v < 0 ? 0 : v));
    return v;
}

void p_02_in6_number_set(number v) {
    this->p_02->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_02->eventinlet_19_out1_number_set(v);
}

number param_18_value_constrain(number v) const {
    v = (v > 18000 ? 18000 : (v < 100 ? 100 : v));
    return v;
}

void p_02_in7_number_set(number v) {
    this->p_02->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_02->eventinlet_20_out1_number_set(v);
}

number param_19_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_02_in8_number_set(number v) {
    this->p_02->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_02->eventinlet_21_out1_number_set(v);
}

number param_20_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_02_in9_number_set(number v) {
    this->p_02->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_02->eventinlet_22_out1_number_set(v);
}

number param_21_value_constrain(number v) const {
    v = (v > 20 ? 20 : (v < 0.5 ? 0.5 : v));
    return v;
}

void p_02_in10_number_set(number v) {
    this->p_02->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_02->eventinlet_23_out1_number_set(v);
}

number param_22_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_02_in11_number_set(number v) {
    this->p_02->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_02->eventinlet_24_out1_number_set(v);
}

number param_23_value_constrain(number v) const {
    v = (v > 8 ? 8 : (v < 0.25 ? 0.25 : v));
    return v;
}

void p_02_in12_number_set(number v) {
    this->p_02->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_02->eventinlet_25_out1_number_set(v);
}

number param_24_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_02_in13_number_set(number v) {
    this->p_02->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_02->eventinlet_26_out1_number_set(v);
}

number param_25_value_constrain(number v) const {
    v = (v > 6000 ? 6000 : (v < 100 ? 100 : v));
    return v;
}

void p_03_in2_number_set(number v) {
    this->p_03->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_03->eventinlet_28_out1_number_set(v);
}

number param_26_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_03_in3_number_set(number v) {
    this->p_03->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_03->eventinlet_29_out1_number_set(v);
}

number param_27_value_constrain(number v) const {
    v = (v > 10000 ? 10000 : (v < 5 ? 5 : v));
    return v;
}

void p_03_in4_number_set(number v) {
    this->p_03->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_03->eventinlet_30_out1_number_set(v);
}

number param_28_value_constrain(number v) const {
    v = (v > 10000 ? 10000 : (v < 5 ? 5 : v));
    return v;
}

void p_03_in5_number_set(number v) {
    this->p_03->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_03->eventinlet_31_out1_number_set(v);
}

number param_29_value_constrain(number v) const {
    v = (v > 4 ? 4 : (v < 0.1 ? 0.1 : v));
    return v;
}

void p_03_in6_number_set(number v) {
    this->p_03->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_03->eventinlet_32_out1_number_set(v);
}

number param_30_value_constrain(number v) const {
    v = (v > 18000 ? 18000 : (v < 100 ? 100 : v));
    return v;
}

void p_03_in7_number_set(number v) {
    this->p_03->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_03->eventinlet_33_out1_number_set(v);
}

number param_31_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_03_in8_number_set(number v) {
    this->p_03->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_03->eventinlet_34_out1_number_set(v);
}

number param_32_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_03_in9_number_set(number v) {
    this->p_03->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_03->eventinlet_35_out1_number_set(v);
}

number param_33_value_constrain(number v) const {
    v = (v > 20 ? 20 : (v < 0.5 ? 0.5 : v));
    return v;
}

void p_03_in10_number_set(number v) {
    this->p_03->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_03->eventinlet_36_out1_number_set(v);
}

number param_34_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_03_in11_number_set(number v) {
    this->p_03->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_03->eventinlet_37_out1_number_set(v);
}

number param_35_value_constrain(number v) const {
    v = (v > 8 ? 8 : (v < 0.25 ? 0.25 : v));
    return v;
}

void p_03_in12_number_set(number v) {
    this->p_03->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_03->eventinlet_38_out1_number_set(v);
}

number param_36_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_03_in13_number_set(number v) {
    this->p_03->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_03->eventinlet_39_out1_number_set(v);
}

number param_37_value_constrain(number v) const {
    v = (v > 8 ? 8 : (v < 1 ? 1 : v));
    return v;
}

void p_04_in2_number_set(number v) {
    this->p_04->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_04->eventinlet_41_out1_number_set(v);
}

number param_38_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_04_in3_number_set(number v) {
    this->p_04->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_04->eventinlet_42_out1_number_set(v);
}

number param_39_value_constrain(number v) const {
    v = (v > 10000 ? 10000 : (v < 5 ? 5 : v));
    return v;
}

void p_04_in4_number_set(number v) {
    this->p_04->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_04->eventinlet_43_out1_number_set(v);
}

number param_40_value_constrain(number v) const {
    v = (v > 200 ? 200 : (v < 1 ? 1 : v));
    return v;
}

void p_04_in5_number_set(number v) {
    this->p_04->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_04->eventinlet_44_out1_number_set(v);
}

number param_41_value_constrain(number v) const {
    v = (v > 100 ? 100 : (v < 2 ? 2 : v));
    return v;
}

void p_04_in6_number_set(number v) {
    this->p_04->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_04->eventinlet_45_out1_number_set(v);
}

number param_42_value_constrain(number v) const {
    v = (v > 18000 ? 18000 : (v < 100 ? 100 : v));
    return v;
}

void p_04_in7_number_set(number v) {
    this->p_04->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_04->eventinlet_46_out1_number_set(v);
}

number param_43_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_04_in8_number_set(number v) {
    this->p_04->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_04->eventinlet_47_out1_number_set(v);
}

number param_44_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_04_in9_number_set(number v) {
    this->p_04->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_04->eventinlet_48_out1_number_set(v);
}

number param_45_value_constrain(number v) const {
    v = (v > 20 ? 20 : (v < 0.5 ? 0.5 : v));
    return v;
}

void p_04_in10_number_set(number v) {
    this->p_04->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_04->eventinlet_49_out1_number_set(v);
}

number param_46_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_04_in11_number_set(number v) {
    this->p_04->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_04->eventinlet_50_out1_number_set(v);
}

number param_47_value_constrain(number v) const {
    v = (v > 8 ? 8 : (v < 0.25 ? 0.25 : v));
    return v;
}

void p_04_in12_number_set(number v) {
    this->p_04->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_04->eventinlet_51_out1_number_set(v);
}

number param_48_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_04_in13_number_set(number v) {
    this->p_04->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_04->eventinlet_52_out1_number_set(v);
}

number param_49_value_constrain(number v) const {
    v = (v > 1600 ? 1600 : (v < 30 ? 30 : v));
    return v;
}

void p_05_in2_number_set(number v) {
    this->p_05->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_05->eventinlet_54_out1_number_set(v);
}

number param_50_value_constrain(number v) const {
    v = (v > 500 ? 500 : (v < 1 ? 1 : v));
    return v;
}

void p_05_in5_number_set(number v) {
    this->p_05->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_05->eventinlet_57_out1_number_set(v);
}

number param_51_value_constrain(number v) const {
    v = (v > 10 ? 10 : (v < 0 ? 0 : v));
    return v;
}

void p_05_in6_number_set(number v) {
    this->p_05->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_05->eventinlet_58_out1_number_set(v);
}

number param_52_value_constrain(number v) const {
    v = (v > 6000 ? 6000 : (v < 10 ? 10 : v));
    return v;
}

void p_05_in3_number_set(number v) {
    this->p_05->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_05->eventinlet_55_out1_number_set(v);
}

number param_53_value_constrain(number v) const {
    v = (v > 1200 ? 1200 : (v < 0 ? 0 : v));
    return v;
}

void p_05_in4_number_set(number v) {
    this->p_05->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_05->eventinlet_56_out1_number_set(v);
}

number param_54_value_constrain(number v) const {
    v = (v > 8 ? 8 : (v < 0.25 ? 0.25 : v));
    return v;
}

void p_05_in7_number_set(number v) {
    this->p_05->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_05->eventinlet_59_out1_number_set(v);
}

number param_55_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_05_in10_number_set(number v) {
    this->p_05->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_05->eventinlet_62_out1_number_set(v);
}

number param_56_value_constrain(number v) const {
    v = (v > 500 ? 500 : (v < 1 ? 1 : v));
    return v;
}

void p_05_in11_number_set(number v) {
    this->p_05->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_05->eventinlet_63_out1_number_set(v);
}

number param_57_value_constrain(number v) const {
    v = (v > 8 ? 8 : (v < 0.25 ? 0.25 : v));
    return v;
}

void p_05_in12_number_set(number v) {
    this->p_05->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_05->eventinlet_64_out1_number_set(v);
}

number param_58_value_constrain(number v) const {
    v = (v > 5 ? 5 : (v < 1 ? 1 : v));
    return v;
}

void p_05_in8_number_set(number v) {
    this->p_05->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_05->eventinlet_60_out1_number_set(v);
}

number param_59_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_05_in9_number_set(number v) {
    this->p_05->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_05->eventinlet_61_out1_number_set(v);
}

number param_60_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_05_in13_number_set(number v) {
    this->p_05->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_05->eventinlet_65_out1_number_set(v);
}

number param_61_value_constrain(number v) const {
    v = (v > 6000 ? 6000 : (v < 100 ? 100 : v));
    return v;
}

void p_06_in2_number_set(number v) {
    this->p_06->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_06->eventinlet_67_out1_number_set(v);
}

number param_62_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_06_in5_number_set(number v) {
    this->p_06->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_06->eventinlet_70_out1_number_set(v);
}

number param_63_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_06_in6_number_set(number v) {
    this->p_06->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_06->eventinlet_71_out1_number_set(v);
}

number param_64_value_constrain(number v) const {
    v = (v > 2000 ? 2000 : (v < 1 ? 1 : v));
    return v;
}

void p_06_in3_number_set(number v) {
    this->p_06->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_06->eventinlet_68_out1_number_set(v);
}

number param_65_value_constrain(number v) const {
    v = (v > 8 ? 8 : (v < 1 ? 1 : v));
    return v;
}

void p_06_in4_number_set(number v) {
    this->p_06->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_06->eventinlet_69_out1_number_set(v);
}

number param_66_value_constrain(number v) const {
    v = (v > 300 ? 300 : (v < 0.5 ? 0.5 : v));
    return v;
}

void p_06_in7_number_set(number v) {
    this->p_06->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_06->eventinlet_72_out1_number_set(v);
}

number param_67_value_constrain(number v) const {
    v = (v > 8 ? 8 : (v < 0 ? 0 : v));
    return v;
}

void p_06_in10_number_set(number v) {
    this->p_06->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_06->eventinlet_75_out1_number_set(v);
}

number param_68_value_constrain(number v) const {
    v = (v > 8 ? 8 : (v < 0.25 ? 0.25 : v));
    return v;
}

void p_06_in11_number_set(number v) {
    this->p_06->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_06->eventinlet_76_out1_number_set(v);
}

number param_69_value_constrain(number v) const {
    v = (v > 8 ? 8 : (v < 0.25 ? 0.25 : v));
    return v;
}

void p_06_in12_number_set(number v) {
    this->p_06->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_06->eventinlet_77_out1_number_set(v);
}

number param_70_value_constrain(number v) const {
    v = (v > 18000 ? 18000 : (v < 200 ? 200 : v));
    return v;
}

void p_06_in8_number_set(number v) {
    this->p_06->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_06->eventinlet_73_out1_number_set(v);
}

number param_71_value_constrain(number v) const {
    v = (v > 15 ? 15 : (v < 0.5 ? 0.5 : v));
    return v;
}

void p_06_in9_number_set(number v) {
    this->p_06->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_06->eventinlet_74_out1_number_set(v);
}

number param_72_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_06_in13_number_set(number v) {
    this->p_06->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_06->eventinlet_78_out1_number_set(v);
}

number param_73_value_constrain(number v) const {
    v = (v > 4000 ? 4000 : (v < 40 ? 40 : v));
    return v;
}

void p_07_in2_number_set(number v) {
    this->p_07->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_07->eventinlet_80_out1_number_set(v);
}

number param_74_value_constrain(number v) const {
    v = (v > 16 ? 16 : (v < 0 ? 0 : v));
    return v;
}

void p_07_in5_number_set(number v) {
    this->p_07->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_07->eventinlet_83_out1_number_set(v);
}

number param_75_value_constrain(number v) const {
    v = (v > 15000 ? 15000 : (v < 5 ? 5 : v));
    return v;
}

void p_07_in6_number_set(number v) {
    this->p_07->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_07->eventinlet_84_out1_number_set(v);
}

number param_76_value_constrain(number v) const {
    v = (v > 15000 ? 15000 : (v < 20 ? 20 : v));
    return v;
}

void p_07_in3_number_set(number v) {
    this->p_07->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_07->eventinlet_81_out1_number_set(v);
}

number param_77_value_constrain(number v) const {
    v = (v > 12 ? 12 : (v < 0.25 ? 0.25 : v));
    return v;
}

void p_07_in4_number_set(number v) {
    this->p_07->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_07->eventinlet_82_out1_number_set(v);
}

number param_78_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_07_in7_number_set(number v) {
    this->p_07->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_07->eventinlet_85_out1_number_set(v);
}

number param_79_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_07_in10_number_set(number v) {
    this->p_07->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_07->eventinlet_88_out1_number_set(v);
}

number param_80_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_07_in11_number_set(number v) {
    this->p_07->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_07->eventinlet_89_out1_number_set(v);
}

number param_81_value_constrain(number v) const {
    v = (v > 6 ? 6 : (v < 0.25 ? 0.25 : v));
    return v;
}

void p_07_in12_number_set(number v) {
    this->p_07->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_07->eventinlet_90_out1_number_set(v);
}

number param_82_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_07_in8_number_set(number v) {
    this->p_07->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_07->eventinlet_86_out1_number_set(v);
}

number param_83_value_constrain(number v) const {
    v = (v > 15000 ? 15000 : (v < 10 ? 10 : v));
    return v;
}

void p_07_in9_number_set(number v) {
    this->p_07->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_07->eventinlet_87_out1_number_set(v);
}

number param_84_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_07_in13_number_set(number v) {
    this->p_07->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_07->eventinlet_91_out1_number_set(v);
}

number param_85_value_constrain(number v) const {
    v = (v > 96 ? 96 : (v < 12 ? 12 : v));
    return v;
}

void p_08_in2_number_set(number v) {
    this->p_08->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_08->eventinlet_93_out1_number_set(v);
}

number param_86_value_constrain(number v) const {
    v = (v > 8 ? 8 : (v < 0.25 ? 0.25 : v));
    return v;
}

void p_08_in5_number_set(number v) {
    this->p_08->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_08->eventinlet_96_out1_number_set(v);
}

number param_87_value_constrain(number v) const {
    v = (v > 6000 ? 6000 : (v < 5 ? 5 : v));
    return v;
}

void p_08_in6_number_set(number v) {
    this->p_08->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_08->eventinlet_97_out1_number_set(v);
}

number param_88_value_constrain(number v) const {
    v = (v > 12000 ? 12000 : (v < 10 ? 10 : v));
    return v;
}

void p_08_in3_number_set(number v) {
    this->p_08->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_08->eventinlet_94_out1_number_set(v);
}

number param_89_value_constrain(number v) const {
    v = (v > 12 ? 12 : (v < 0 ? 0 : v));
    return v;
}

void p_08_in4_number_set(number v) {
    this->p_08->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_08->eventinlet_95_out1_number_set(v);
}

number param_90_value_constrain(number v) const {
    v = (v > 0.95 ? 0.95 : (v < 0 ? 0 : v));
    return v;
}

void p_08_in7_number_set(number v) {
    this->p_08->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_08->eventinlet_98_out1_number_set(v);
}

number param_91_value_constrain(number v) const {
    v = (v > 1000 ? 1000 : (v < 0.2 ? 0.2 : v));
    return v;
}

void p_08_in10_number_set(number v) {
    this->p_08->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_08->eventinlet_101_out1_number_set(v);
}

number param_92_value_constrain(number v) const {
    v = (v > 24 ? 24 : (v < -24 ? -24 : v));
    return v;
}

void p_08_in11_number_set(number v) {
    this->p_08->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_08->eventinlet_102_out1_number_set(v);
}

number param_93_value_constrain(number v) const {
    v = (v > 8 ? 8 : (v < 0.25 ? 0.25 : v));
    return v;
}

void p_08_in12_number_set(number v) {
    this->p_08->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_08->eventinlet_103_out1_number_set(v);
}

number param_94_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_08_in8_number_set(number v) {
    this->p_08->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_08->eventinlet_99_out1_number_set(v);
}

number param_95_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_08_in9_number_set(number v) {
    this->p_08->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_08->eventinlet_100_out1_number_set(v);
}

number param_96_value_constrain(number v) const {
    v = (v > 1 ? 1 : (v < 0 ? 0 : v));
    return v;
}

void p_08_in13_number_set(number v) {
    this->p_08->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_08->eventinlet_104_out1_number_set(v);
}

void p_01_in1_bang_bang() {
    this->p_01->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_01->eventinlet_01_out1_bang_bang();
}

void inport_01_out_bang_bang() {
    this->p_01_in1_bang_bang();
}

void p_01_in1_number_set(number v) {
    this->p_01->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_01->eventinlet_01_out1_number_set(v);
}

void inport_01_out_number_set(number v) {
    this->p_01_in1_number_set(v);
}

template<typename LISTTYPE> void p_01_in1_list_set(const LISTTYPE& v) {
    this->p_01->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_01->eventinlet_01_out1_list_set(v);
}

template<typename LISTTYPE> void inport_01_out_list_set(const LISTTYPE& v) {
    this->p_01_in1_list_set(v);
}

void p_02_in1_bang_bang() {
    this->p_02->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_02->eventinlet_14_out1_bang_bang();
}

void inport_02_out_bang_bang() {
    this->p_02_in1_bang_bang();
}

void p_02_in1_number_set(number v) {
    this->p_02->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_02->eventinlet_14_out1_number_set(v);
}

void inport_02_out_number_set(number v) {
    this->p_02_in1_number_set(v);
}

template<typename LISTTYPE> void p_02_in1_list_set(const LISTTYPE& v) {
    this->p_02->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_02->eventinlet_14_out1_list_set(v);
}

template<typename LISTTYPE> void inport_02_out_list_set(const LISTTYPE& v) {
    this->p_02_in1_list_set(v);
}

void p_03_in1_bang_bang() {
    this->p_03->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_03->eventinlet_27_out1_bang_bang();
}

void inport_03_out_bang_bang() {
    this->p_03_in1_bang_bang();
}

void p_03_in1_number_set(number v) {
    this->p_03->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_03->eventinlet_27_out1_number_set(v);
}

void inport_03_out_number_set(number v) {
    this->p_03_in1_number_set(v);
}

template<typename LISTTYPE> void p_03_in1_list_set(const LISTTYPE& v) {
    this->p_03->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_03->eventinlet_27_out1_list_set(v);
}

template<typename LISTTYPE> void inport_03_out_list_set(const LISTTYPE& v) {
    this->p_03_in1_list_set(v);
}

void p_04_in1_bang_bang() {
    this->p_04->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_04->eventinlet_40_out1_bang_bang();
}

void inport_04_out_bang_bang() {
    this->p_04_in1_bang_bang();
}

void p_04_in1_number_set(number v) {
    this->p_04->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_04->eventinlet_40_out1_number_set(v);
}

void inport_04_out_number_set(number v) {
    this->p_04_in1_number_set(v);
}

template<typename LISTTYPE> void p_04_in1_list_set(const LISTTYPE& v) {
    this->p_04->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_04->eventinlet_40_out1_list_set(v);
}

template<typename LISTTYPE> void inport_04_out_list_set(const LISTTYPE& v) {
    this->p_04_in1_list_set(v);
}

void p_05_in1_bang_bang() {
    this->p_05->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_05->eventinlet_53_out1_bang_bang();
}

void inport_05_out_bang_bang() {
    this->p_05_in1_bang_bang();
}

void p_05_in1_number_set(number v) {
    this->p_05->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_05->eventinlet_53_out1_number_set(v);
}

void inport_05_out_number_set(number v) {
    this->p_05_in1_number_set(v);
}

template<typename LISTTYPE> void p_05_in1_list_set(const LISTTYPE& v) {
    this->p_05->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_05->eventinlet_53_out1_list_set(v);
}

template<typename LISTTYPE> void inport_05_out_list_set(const LISTTYPE& v) {
    this->p_05_in1_list_set(v);
}

void p_06_in1_bang_bang() {
    this->p_06->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_06->eventinlet_66_out1_bang_bang();
}

void inport_06_out_bang_bang() {
    this->p_06_in1_bang_bang();
}

void p_06_in1_number_set(number v) {
    this->p_06->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_06->eventinlet_66_out1_number_set(v);
}

void inport_06_out_number_set(number v) {
    this->p_06_in1_number_set(v);
}

template<typename LISTTYPE> void p_06_in1_list_set(const LISTTYPE& v) {
    this->p_06->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_06->eventinlet_66_out1_list_set(v);
}

template<typename LISTTYPE> void inport_06_out_list_set(const LISTTYPE& v) {
    this->p_06_in1_list_set(v);
}

void p_07_in1_bang_bang() {
    this->p_07->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_07->eventinlet_79_out1_bang_bang();
}

void inport_07_out_bang_bang() {
    this->p_07_in1_bang_bang();
}

void p_07_in1_number_set(number v) {
    this->p_07->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_07->eventinlet_79_out1_number_set(v);
}

void inport_07_out_number_set(number v) {
    this->p_07_in1_number_set(v);
}

template<typename LISTTYPE> void p_07_in1_list_set(const LISTTYPE& v) {
    this->p_07->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_07->eventinlet_79_out1_list_set(v);
}

template<typename LISTTYPE> void inport_07_out_list_set(const LISTTYPE& v) {
    this->p_07_in1_list_set(v);
}

void p_08_in1_bang_bang() {
    this->p_08->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_08->eventinlet_92_out1_bang_bang();
}

void inport_08_out_bang_bang() {
    this->p_08_in1_bang_bang();
}

void p_08_in1_number_set(number v) {
    this->p_08->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_08->eventinlet_92_out1_number_set(v);
}

void inport_08_out_number_set(number v) {
    this->p_08_in1_number_set(v);
}

template<typename LISTTYPE> void p_08_in1_list_set(const LISTTYPE& v) {
    this->p_08->updateTime(this->_currentTime, (ENGINE*)nullptr);
    this->p_08->eventinlet_92_out1_list_set(v);
}

template<typename LISTTYPE> void inport_08_out_list_set(const LISTTYPE& v) {
    this->p_08_in1_list_set(v);
}

void p_01_perform(SampleValue * out1, SampleValue * out2, Index n) {
    // subpatcher: kick_core
    SampleArray<2> outs = {out1, out2};

    this->p_01->process(nullptr, 0, outs, 2, n);
}

void p_02_perform(SampleValue * out1, SampleValue * out2, Index n) {
    // subpatcher: snare_core
    SampleArray<2> outs = {out1, out2};

    this->p_02->process(nullptr, 0, outs, 2, n);
}

void p_03_perform(SampleValue * out1, SampleValue * out2, Index n) {
    // subpatcher: hat_core
    SampleArray<2> outs = {out1, out2};

    this->p_03->process(nullptr, 0, outs, 2, n);
}

void p_04_perform(SampleValue * out1, SampleValue * out2, Index n) {
    // subpatcher: clap_core
    SampleArray<2> outs = {out1, out2};

    this->p_04->process(nullptr, 0, outs, 2, n);
}

void p_05_perform(SampleValue * out1, SampleValue * out2, Index n) {
    // subpatcher: tom_core
    SampleArray<2> outs = {out1, out2};

    this->p_05->process(nullptr, 0, outs, 2, n);
}

void p_06_perform(SampleValue * out1, SampleValue * out2, Index n) {
    // subpatcher: rim_core
    SampleArray<2> outs = {out1, out2};

    this->p_06->process(nullptr, 0, outs, 2, n);
}

void p_07_perform(SampleValue * out1, SampleValue * out2, Index n) {
    // subpatcher: bell_core
    SampleArray<2> outs = {out1, out2};

    this->p_07->process(nullptr, 0, outs, 2, n);
}

void p_08_perform(SampleValue * out1, SampleValue * out2, Index n) {
    // subpatcher: bass_core
    SampleArray<2> outs = {out1, out2};

    this->p_08->process(nullptr, 0, outs, 2, n);
}

void stackprotect_perform(Index n) {
    RNBO_UNUSED(n);
    auto __stackprotect_count = this->stackprotect_count;
    __stackprotect_count = 0;
    this->stackprotect_count = __stackprotect_count;
}

void param_01_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_01_value;
}

void param_01_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_01_value_set(preset["value"]);
}

void param_02_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_02_value;
}

void param_02_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_02_value_set(preset["value"]);
}

void param_03_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_03_value;
}

void param_03_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_03_value_set(preset["value"]);
}

void param_04_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_04_value;
}

void param_04_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_04_value_set(preset["value"]);
}

void param_05_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_05_value;
}

void param_05_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_05_value_set(preset["value"]);
}

void param_06_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_06_value;
}

void param_06_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_06_value_set(preset["value"]);
}

void param_07_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_07_value;
}

void param_07_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_07_value_set(preset["value"]);
}

void param_08_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_08_value;
}

void param_08_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_08_value_set(preset["value"]);
}

void param_09_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_09_value;
}

void param_09_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_09_value_set(preset["value"]);
}

void param_10_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_10_value;
}

void param_10_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_10_value_set(preset["value"]);
}

void param_11_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_11_value;
}

void param_11_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_11_value_set(preset["value"]);
}

void param_12_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_12_value;
}

void param_12_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_12_value_set(preset["value"]);
}

void param_13_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_13_value;
}

void param_13_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_13_value_set(preset["value"]);
}

void param_14_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_14_value;
}

void param_14_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_14_value_set(preset["value"]);
}

void param_15_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_15_value;
}

void param_15_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_15_value_set(preset["value"]);
}

void param_16_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_16_value;
}

void param_16_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_16_value_set(preset["value"]);
}

void param_17_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_17_value;
}

void param_17_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_17_value_set(preset["value"]);
}

void param_18_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_18_value;
}

void param_18_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_18_value_set(preset["value"]);
}

void param_19_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_19_value;
}

void param_19_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_19_value_set(preset["value"]);
}

void param_20_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_20_value;
}

void param_20_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_20_value_set(preset["value"]);
}

void param_21_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_21_value;
}

void param_21_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_21_value_set(preset["value"]);
}

void param_22_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_22_value;
}

void param_22_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_22_value_set(preset["value"]);
}

void param_23_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_23_value;
}

void param_23_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_23_value_set(preset["value"]);
}

void param_24_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_24_value;
}

void param_24_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_24_value_set(preset["value"]);
}

void param_25_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_25_value;
}

void param_25_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_25_value_set(preset["value"]);
}

void param_26_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_26_value;
}

void param_26_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_26_value_set(preset["value"]);
}

void param_27_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_27_value;
}

void param_27_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_27_value_set(preset["value"]);
}

void param_28_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_28_value;
}

void param_28_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_28_value_set(preset["value"]);
}

void param_29_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_29_value;
}

void param_29_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_29_value_set(preset["value"]);
}

void param_30_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_30_value;
}

void param_30_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_30_value_set(preset["value"]);
}

void param_31_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_31_value;
}

void param_31_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_31_value_set(preset["value"]);
}

void param_32_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_32_value;
}

void param_32_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_32_value_set(preset["value"]);
}

void param_33_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_33_value;
}

void param_33_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_33_value_set(preset["value"]);
}

void param_34_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_34_value;
}

void param_34_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_34_value_set(preset["value"]);
}

void param_35_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_35_value;
}

void param_35_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_35_value_set(preset["value"]);
}

void param_36_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_36_value;
}

void param_36_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_36_value_set(preset["value"]);
}

void param_37_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_37_value;
}

void param_37_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_37_value_set(preset["value"]);
}

void param_38_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_38_value;
}

void param_38_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_38_value_set(preset["value"]);
}

void param_39_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_39_value;
}

void param_39_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_39_value_set(preset["value"]);
}

void param_40_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_40_value;
}

void param_40_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_40_value_set(preset["value"]);
}

void param_41_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_41_value;
}

void param_41_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_41_value_set(preset["value"]);
}

void param_42_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_42_value;
}

void param_42_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_42_value_set(preset["value"]);
}

void param_43_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_43_value;
}

void param_43_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_43_value_set(preset["value"]);
}

void param_44_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_44_value;
}

void param_44_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_44_value_set(preset["value"]);
}

void param_45_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_45_value;
}

void param_45_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_45_value_set(preset["value"]);
}

void param_46_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_46_value;
}

void param_46_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_46_value_set(preset["value"]);
}

void param_47_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_47_value;
}

void param_47_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_47_value_set(preset["value"]);
}

void param_48_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_48_value;
}

void param_48_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_48_value_set(preset["value"]);
}

void param_49_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_49_value;
}

void param_49_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_49_value_set(preset["value"]);
}

void param_50_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_50_value;
}

void param_50_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_50_value_set(preset["value"]);
}

void param_51_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_51_value;
}

void param_51_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_51_value_set(preset["value"]);
}

void param_52_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_52_value;
}

void param_52_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_52_value_set(preset["value"]);
}

void param_53_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_53_value;
}

void param_53_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_53_value_set(preset["value"]);
}

void param_54_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_54_value;
}

void param_54_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_54_value_set(preset["value"]);
}

void param_55_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_55_value;
}

void param_55_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_55_value_set(preset["value"]);
}

void param_56_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_56_value;
}

void param_56_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_56_value_set(preset["value"]);
}

void param_57_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_57_value;
}

void param_57_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_57_value_set(preset["value"]);
}

void param_58_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_58_value;
}

void param_58_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_58_value_set(preset["value"]);
}

void param_59_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_59_value;
}

void param_59_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_59_value_set(preset["value"]);
}

void param_60_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_60_value;
}

void param_60_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_60_value_set(preset["value"]);
}

void param_61_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_61_value;
}

void param_61_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_61_value_set(preset["value"]);
}

void param_62_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_62_value;
}

void param_62_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_62_value_set(preset["value"]);
}

void param_63_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_63_value;
}

void param_63_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_63_value_set(preset["value"]);
}

void param_64_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_64_value;
}

void param_64_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_64_value_set(preset["value"]);
}

void param_65_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_65_value;
}

void param_65_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_65_value_set(preset["value"]);
}

void param_66_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_66_value;
}

void param_66_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_66_value_set(preset["value"]);
}

void param_67_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_67_value;
}

void param_67_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_67_value_set(preset["value"]);
}

void param_68_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_68_value;
}

void param_68_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_68_value_set(preset["value"]);
}

void param_69_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_69_value;
}

void param_69_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_69_value_set(preset["value"]);
}

void param_70_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_70_value;
}

void param_70_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_70_value_set(preset["value"]);
}

void param_71_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_71_value;
}

void param_71_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_71_value_set(preset["value"]);
}

void param_72_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_72_value;
}

void param_72_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_72_value_set(preset["value"]);
}

void param_73_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_73_value;
}

void param_73_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_73_value_set(preset["value"]);
}

void param_74_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_74_value;
}

void param_74_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_74_value_set(preset["value"]);
}

void param_75_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_75_value;
}

void param_75_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_75_value_set(preset["value"]);
}

void param_76_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_76_value;
}

void param_76_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_76_value_set(preset["value"]);
}

void param_77_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_77_value;
}

void param_77_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_77_value_set(preset["value"]);
}

void param_78_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_78_value;
}

void param_78_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_78_value_set(preset["value"]);
}

void param_79_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_79_value;
}

void param_79_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_79_value_set(preset["value"]);
}

void param_80_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_80_value;
}

void param_80_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_80_value_set(preset["value"]);
}

void param_81_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_81_value;
}

void param_81_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_81_value_set(preset["value"]);
}

void param_82_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_82_value;
}

void param_82_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_82_value_set(preset["value"]);
}

void param_83_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_83_value;
}

void param_83_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_83_value_set(preset["value"]);
}

void param_84_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_84_value;
}

void param_84_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_84_value_set(preset["value"]);
}

void param_85_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_85_value;
}

void param_85_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_85_value_set(preset["value"]);
}

void param_86_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_86_value;
}

void param_86_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_86_value_set(preset["value"]);
}

void param_87_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_87_value;
}

void param_87_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_87_value_set(preset["value"]);
}

void param_88_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_88_value;
}

void param_88_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_88_value_set(preset["value"]);
}

void param_89_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_89_value;
}

void param_89_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_89_value_set(preset["value"]);
}

void param_90_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_90_value;
}

void param_90_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_90_value_set(preset["value"]);
}

void param_91_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_91_value;
}

void param_91_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_91_value_set(preset["value"]);
}

void param_92_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_92_value;
}

void param_92_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_92_value_set(preset["value"]);
}

void param_93_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_93_value;
}

void param_93_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_93_value_set(preset["value"]);
}

void param_94_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_94_value;
}

void param_94_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_94_value_set(preset["value"]);
}

void param_95_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_95_value;
}

void param_95_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_95_value_set(preset["value"]);
}

void param_96_getPresetValue(PatcherStateInterface& preset) {
    preset["value"] = this->param_96_value;
}

void param_96_setPresetValue(PatcherStateInterface& preset) {
    if ((bool)(stateIsEmpty(preset)))
        return;

    this->param_96_value_set(preset["value"]);
}

void globaltransport_advance() {}

void globaltransport_dspsetup(bool ) {}

bool stackprotect_check() {
    this->stackprotect_count++;

    if (this->stackprotect_count > 128) {
        console->log("STACK OVERFLOW DETECTED - stopped processing branch !");
        return true;
    }

    return false;
}

Index getPatcherSerial() const {
    return 0;
}

void sendParameter(ParameterIndex index, bool ignoreValue) {
    this->getEngine()->notifyParameterValueChanged(index, (ignoreValue ? 0 : this->getParameterValue(index)), ignoreValue);
}

void scheduleParamInit(ParameterIndex index, Index order) {
    this->paramInitIndices->push(index);
    this->paramInitOrder->push(order);
}

void processParamInitEvents() {
    this->listquicksort(
        this->paramInitOrder,
        this->paramInitIndices,
        0,
        (int)(this->paramInitOrder->length - 1),
        true
    );

    for (Index i = 0; i < this->paramInitOrder->length; i++) {
        this->getEngine()->scheduleParameterBang(this->paramInitIndices[i], 0);
    }
}

void updateTime(MillisecondTime time, EXTERNALENGINE* engine, bool inProcess = false) {
    RNBO_UNUSED(inProcess);
    RNBO_UNUSED(engine);
    this->_currentTime = time;
    auto offset = rnbo_fround(this->msToSamps(time - this->getEngine()->getCurrentTime(), this->sr));

    if (offset >= (SampleIndex)(this->vs))
        offset = (SampleIndex)(this->vs) - 1;

    if (offset < 0)
        offset = 0;

    this->sampleOffsetIntoNextAudioBuffer = (Index)(offset);
}

void assign_defaults()
{
    param_01_value = 48;
    param_02_value = 150;
    param_03_value = 32;
    param_04_value = 620;
    param_05_value = 0.15;
    param_06_value = 1.5;
    p_01_target = 0;
    param_07_value = 0.22;
    param_08_value = 58;
    param_09_value = 8;
    param_10_value = 0.08;
    param_11_value = 1.8;
    param_12_value = 0.5;
    param_13_value = 180;
    param_14_value = 90;
    param_15_value = 260;
    param_16_value = 180;
    param_17_value = 0.35;
    param_18_value = 3500;
    p_02_target = 0;
    param_19_value = 0.65;
    param_20_value = 0.72;
    param_21_value = 1.1;
    param_22_value = 0.45;
    param_23_value = 1.7;
    param_24_value = 0.45;
    param_25_value = 700;
    param_26_value = 0.65;
    param_27_value = 85;
    param_28_value = 120;
    param_29_value = 1;
    param_30_value = 6500;
    p_03_target = 0;
    param_31_value = 0.7;
    param_32_value = 0.55;
    param_33_value = 0.8;
    param_34_value = 0.4;
    param_35_value = 1.4;
    param_36_value = 0.4;
    param_37_value = 3;
    param_38_value = 0.15;
    param_39_value = 280;
    param_40_value = 10;
    param_41_value = 12;
    param_42_value = 1600;
    p_04_target = 0;
    param_43_value = 0.45;
    param_44_value = 0.65;
    param_45_value = 1.1;
    param_46_value = 0.2;
    param_47_value = 1.5;
    param_48_value = 0.5;
    param_49_value = 140;
    param_50_value = 35;
    param_51_value = 0.5;
    param_52_value = 450;
    param_53_value = 160;
    param_54_value = 1.5;
    p_05_target = 0;
    param_55_value = 0.08;
    param_56_value = 12;
    param_57_value = 1.3;
    param_58_value = 1.59;
    param_59_value = 0.25;
    param_60_value = 0.5;
    param_61_value = 850;
    param_62_value = 0.65;
    param_63_value = 0.6;
    param_64_value = 65;
    param_65_value = 2.73;
    param_66_value = 4;
    p_06_target = 0;
    param_67_value = 0.2;
    param_68_value = 2;
    param_69_value = 1.8;
    param_70_value = 4200;
    param_71_value = 1.2;
    param_72_value = 0.45;
    param_73_value = 440;
    param_74_value = 3;
    param_75_value = 700;
    param_76_value = 1600;
    param_77_value = 2.71;
    param_78_value = 0.4;
    p_07_target = 0;
    param_79_value = 0.2;
    param_80_value = 0.65;
    param_81_value = 1;
    param_82_value = 0.3;
    param_83_value = 900;
    param_84_value = 0.35;
    param_85_value = 36;
    param_86_value = 1;
    param_87_value = 220;
    param_88_value = 550;
    param_89_value = 1.2;
    param_90_value = 0.15;
    p_08_target = 0;
    param_91_value = 2;
    param_92_value = 0;
    param_93_value = 1.4;
    param_94_value = 0.35;
    param_95_value = 0.6;
    param_96_value = 0.45;
    _currentTime = 0;
    audioProcessSampleCount = 0;
    sampleOffsetIntoNextAudioBuffer = 0;
    zeroBuffer = nullptr;
    dummyBuffer = nullptr;
    didAllocateSignals = 0;
    vs = 0;
    maxvs = 0;
    sr = 44100;
    invsr = 0.000022675736961451248;
    param_01_lastValue = 0;
    param_02_lastValue = 0;
    param_03_lastValue = 0;
    param_04_lastValue = 0;
    param_05_lastValue = 0;
    param_06_lastValue = 0;
    param_07_lastValue = 0;
    param_08_lastValue = 0;
    param_09_lastValue = 0;
    param_10_lastValue = 0;
    param_11_lastValue = 0;
    param_12_lastValue = 0;
    param_13_lastValue = 0;
    param_14_lastValue = 0;
    param_15_lastValue = 0;
    param_16_lastValue = 0;
    param_17_lastValue = 0;
    param_18_lastValue = 0;
    param_19_lastValue = 0;
    param_20_lastValue = 0;
    param_21_lastValue = 0;
    param_22_lastValue = 0;
    param_23_lastValue = 0;
    param_24_lastValue = 0;
    param_25_lastValue = 0;
    param_26_lastValue = 0;
    param_27_lastValue = 0;
    param_28_lastValue = 0;
    param_29_lastValue = 0;
    param_30_lastValue = 0;
    param_31_lastValue = 0;
    param_32_lastValue = 0;
    param_33_lastValue = 0;
    param_34_lastValue = 0;
    param_35_lastValue = 0;
    param_36_lastValue = 0;
    param_37_lastValue = 0;
    param_38_lastValue = 0;
    param_39_lastValue = 0;
    param_40_lastValue = 0;
    param_41_lastValue = 0;
    param_42_lastValue = 0;
    param_43_lastValue = 0;
    param_44_lastValue = 0;
    param_45_lastValue = 0;
    param_46_lastValue = 0;
    param_47_lastValue = 0;
    param_48_lastValue = 0;
    param_49_lastValue = 0;
    param_50_lastValue = 0;
    param_51_lastValue = 0;
    param_52_lastValue = 0;
    param_53_lastValue = 0;
    param_54_lastValue = 0;
    param_55_lastValue = 0;
    param_56_lastValue = 0;
    param_57_lastValue = 0;
    param_58_lastValue = 0;
    param_59_lastValue = 0;
    param_60_lastValue = 0;
    param_61_lastValue = 0;
    param_62_lastValue = 0;
    param_63_lastValue = 0;
    param_64_lastValue = 0;
    param_65_lastValue = 0;
    param_66_lastValue = 0;
    param_67_lastValue = 0;
    param_68_lastValue = 0;
    param_69_lastValue = 0;
    param_70_lastValue = 0;
    param_71_lastValue = 0;
    param_72_lastValue = 0;
    param_73_lastValue = 0;
    param_74_lastValue = 0;
    param_75_lastValue = 0;
    param_76_lastValue = 0;
    param_77_lastValue = 0;
    param_78_lastValue = 0;
    param_79_lastValue = 0;
    param_80_lastValue = 0;
    param_81_lastValue = 0;
    param_82_lastValue = 0;
    param_83_lastValue = 0;
    param_84_lastValue = 0;
    param_85_lastValue = 0;
    param_86_lastValue = 0;
    param_87_lastValue = 0;
    param_88_lastValue = 0;
    param_89_lastValue = 0;
    param_90_lastValue = 0;
    param_91_lastValue = 0;
    param_92_lastValue = 0;
    param_93_lastValue = 0;
    param_94_lastValue = 0;
    param_95_lastValue = 0;
    param_96_lastValue = 0;
    globaltransport_tempo = nullptr;
    globaltransport_state = nullptr;
    stackprotect_count = 0;
    _voiceIndex = 0;
    _noteNumber = 0;
    isMuted = 1;
}

// member variables

    number param_01_value;
    number param_02_value;
    number param_03_value;
    number param_04_value;
    number param_05_value;
    number param_06_value;
    number p_01_target;
    number param_07_value;
    number param_08_value;
    number param_09_value;
    number param_10_value;
    number param_11_value;
    number param_12_value;
    number param_13_value;
    number param_14_value;
    number param_15_value;
    number param_16_value;
    number param_17_value;
    number param_18_value;
    number p_02_target;
    number param_19_value;
    number param_20_value;
    number param_21_value;
    number param_22_value;
    number param_23_value;
    number param_24_value;
    number param_25_value;
    number param_26_value;
    number param_27_value;
    number param_28_value;
    number param_29_value;
    number param_30_value;
    number p_03_target;
    number param_31_value;
    number param_32_value;
    number param_33_value;
    number param_34_value;
    number param_35_value;
    number param_36_value;
    number param_37_value;
    number param_38_value;
    number param_39_value;
    number param_40_value;
    number param_41_value;
    number param_42_value;
    number p_04_target;
    number param_43_value;
    number param_44_value;
    number param_45_value;
    number param_46_value;
    number param_47_value;
    number param_48_value;
    number param_49_value;
    number param_50_value;
    number param_51_value;
    number param_52_value;
    number param_53_value;
    number param_54_value;
    number p_05_target;
    number param_55_value;
    number param_56_value;
    number param_57_value;
    number param_58_value;
    number param_59_value;
    number param_60_value;
    number param_61_value;
    number param_62_value;
    number param_63_value;
    number param_64_value;
    number param_65_value;
    number param_66_value;
    number p_06_target;
    number param_67_value;
    number param_68_value;
    number param_69_value;
    number param_70_value;
    number param_71_value;
    number param_72_value;
    number param_73_value;
    number param_74_value;
    number param_75_value;
    number param_76_value;
    number param_77_value;
    number param_78_value;
    number p_07_target;
    number param_79_value;
    number param_80_value;
    number param_81_value;
    number param_82_value;
    number param_83_value;
    number param_84_value;
    number param_85_value;
    number param_86_value;
    number param_87_value;
    number param_88_value;
    number param_89_value;
    number param_90_value;
    number p_08_target;
    number param_91_value;
    number param_92_value;
    number param_93_value;
    number param_94_value;
    number param_95_value;
    number param_96_value;
    MillisecondTime _currentTime;
    ENGINE _internalEngine;
    UInt64 audioProcessSampleCount;
    Index sampleOffsetIntoNextAudioBuffer;
    signal zeroBuffer;
    signal dummyBuffer;
    bool didAllocateSignals;
    Index vs;
    Index maxvs;
    number sr;
    number invsr;
    number param_01_lastValue;
    number param_02_lastValue;
    number param_03_lastValue;
    number param_04_lastValue;
    number param_05_lastValue;
    number param_06_lastValue;
    number param_07_lastValue;
    number param_08_lastValue;
    number param_09_lastValue;
    number param_10_lastValue;
    number param_11_lastValue;
    number param_12_lastValue;
    number param_13_lastValue;
    number param_14_lastValue;
    number param_15_lastValue;
    number param_16_lastValue;
    number param_17_lastValue;
    number param_18_lastValue;
    number param_19_lastValue;
    number param_20_lastValue;
    number param_21_lastValue;
    number param_22_lastValue;
    number param_23_lastValue;
    number param_24_lastValue;
    number param_25_lastValue;
    number param_26_lastValue;
    number param_27_lastValue;
    number param_28_lastValue;
    number param_29_lastValue;
    number param_30_lastValue;
    number param_31_lastValue;
    number param_32_lastValue;
    number param_33_lastValue;
    number param_34_lastValue;
    number param_35_lastValue;
    number param_36_lastValue;
    number param_37_lastValue;
    number param_38_lastValue;
    number param_39_lastValue;
    number param_40_lastValue;
    number param_41_lastValue;
    number param_42_lastValue;
    number param_43_lastValue;
    number param_44_lastValue;
    number param_45_lastValue;
    number param_46_lastValue;
    number param_47_lastValue;
    number param_48_lastValue;
    number param_49_lastValue;
    number param_50_lastValue;
    number param_51_lastValue;
    number param_52_lastValue;
    number param_53_lastValue;
    number param_54_lastValue;
    number param_55_lastValue;
    number param_56_lastValue;
    number param_57_lastValue;
    number param_58_lastValue;
    number param_59_lastValue;
    number param_60_lastValue;
    number param_61_lastValue;
    number param_62_lastValue;
    number param_63_lastValue;
    number param_64_lastValue;
    number param_65_lastValue;
    number param_66_lastValue;
    number param_67_lastValue;
    number param_68_lastValue;
    number param_69_lastValue;
    number param_70_lastValue;
    number param_71_lastValue;
    number param_72_lastValue;
    number param_73_lastValue;
    number param_74_lastValue;
    number param_75_lastValue;
    number param_76_lastValue;
    number param_77_lastValue;
    number param_78_lastValue;
    number param_79_lastValue;
    number param_80_lastValue;
    number param_81_lastValue;
    number param_82_lastValue;
    number param_83_lastValue;
    number param_84_lastValue;
    number param_85_lastValue;
    number param_86_lastValue;
    number param_87_lastValue;
    number param_88_lastValue;
    number param_89_lastValue;
    number param_90_lastValue;
    number param_91_lastValue;
    number param_92_lastValue;
    number param_93_lastValue;
    number param_94_lastValue;
    number param_95_lastValue;
    number param_96_lastValue;
    signal globaltransport_tempo;
    signal globaltransport_state;
    number stackprotect_count;
    Index _voiceIndex;
    Int _noteNumber;
    Index isMuted;
    indexlist paramInitIndices;
    indexlist paramInitOrder;
    RNBOSubpatcher_118 p_01;
    RNBOSubpatcher_119 p_02;
    RNBOSubpatcher_120 p_03;
    RNBOSubpatcher_121 p_04;
    RNBOSubpatcher_122 p_05;
    RNBOSubpatcher_123 p_06;
    RNBOSubpatcher_124 p_07;
    RNBOSubpatcher_125 p_08;
    bool _isInitialized = false;
};

static PatcherInterface* creaternbomatic()
{
    return new rnbomatic<EXTERNALENGINE>();
}

#ifndef RNBO_NO_PATCHERFACTORY
extern "C" PatcherFactoryFunctionPtr GetPatcherFactoryFunction()
#else
extern "C" PatcherFactoryFunctionPtr rnbomaticFactoryFunction()
#endif
{
    return creaternbomatic;
}

#ifndef RNBO_NO_PATCHERFACTORY
extern "C" void SetLogger(Logger* logger)
#else
void rnbomaticSetLogger(Logger* logger)
#endif
{
    console = logger;
}

} // end RNBO namespace

