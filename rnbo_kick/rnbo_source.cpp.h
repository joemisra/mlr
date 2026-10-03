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
    this->p_01_perform(out1, out2, n);
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
    default:
        {
        index -= 12;

        if (index < this->p_01->getNumParameters())
            this->p_01->setParameterValue(index, v, time);

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
    default:
        {
        index -= 12;

        if (index < this->p_01->getNumParameters())
            return this->p_01->getParameterValue(index);

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
    return 12 + this->p_01->getNumParameters();
}

ConstCharPointer getParameterName(ParameterIndex index) const {
    switch (index) {
    case 0:
        {
        return "baseHz";
        }
    case 1:
        {
        return "pitchAmount";
        }
    case 2:
        {
        return "pitchDecayMs";
        }
    case 3:
        {
        return "ampDecayMs";
        }
    case 4:
        {
        return "fmIndex";
        }
    case 5:
        {
        return "fmRatio";
        }
    case 6:
        {
        return "resonMix";
        }
    case 7:
        {
        return "resonHz";
        }
    case 8:
        {
        return "resonQ";
        }
    case 9:
        {
        return "clickLevel";
        }
    case 10:
        {
        return "drive";
        }
    case 11:
        {
        return "level";
        }
    default:
        {
        index -= 12;

        if (index < this->p_01->getNumParameters())
            return this->p_01->getParameterName(index);

        return "bogus";
        }
    }
}

ConstCharPointer getParameterId(ParameterIndex index) const {
    switch (index) {
    case 0:
        {
        return "baseHz";
        }
    case 1:
        {
        return "pitchAmount";
        }
    case 2:
        {
        return "pitchDecayMs";
        }
    case 3:
        {
        return "ampDecayMs";
        }
    case 4:
        {
        return "fmIndex";
        }
    case 5:
        {
        return "fmRatio";
        }
    case 6:
        {
        return "resonMix";
        }
    case 7:
        {
        return "resonHz";
        }
    case 8:
        {
        return "resonQ";
        }
    case 9:
        {
        return "clickLevel";
        }
    case 10:
        {
        return "drive";
        }
    case 11:
        {
        return "level";
        }
    default:
        {
        index -= 12;

        if (index < this->p_01->getNumParameters())
            return this->p_01->getParameterId(index);

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
        default:
            {
            index -= 12;

            if (index < this->p_01->getNumParameters())
                this->p_01->getParameterInfo(index, info);

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
        {
        {
            value = (value < 0 ? 0 : (value > 1 ? 1 : value));
            ParameterValue normalizedValue = (value - 0) / (1 - 0);
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
    case 2:
        {
        {
            value = (value < 1 ? 1 : (value > 300 ? 300 : value));
            ParameterValue normalizedValue = (value - 1) / (300 - 1);
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
    case 0:
        {
        {
            value = (value < 10 ? 10 : (value > 2000 ? 2000 : value));
            ParameterValue normalizedValue = (value - 10) / (2000 - 10);
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
    case 5:
        {
        {
            value = (value < 0.125 ? 0.125 : (value > 8 ? 8 : value));
            ParameterValue normalizedValue = (value - 0.125) / (8 - 0.125);
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
    case 10:
        {
        {
            value = (value < 0.25 ? 0.25 : (value > 8 ? 8 : value));
            ParameterValue normalizedValue = (value - 0.25) / (8 - 0.25);
            return normalizedValue;
        }
        }
    default:
        {
        index -= 12;

        if (index < this->p_01->getNumParameters())
            return this->p_01->convertToNormalizedParameterValue(index, value);

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
        {
        {
            {
                return 0 + value * (1 - 0);
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
    case 2:
        {
        {
            {
                return 1 + value * (300 - 1);
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
    case 0:
        {
        {
            {
                return 10 + value * (2000 - 10);
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
    case 5:
        {
        {
            {
                return 0.125 + value * (8 - 0.125);
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
    case 10:
        {
        {
            {
                return 0.25 + value * (8 - 0.25);
            }
        }
        }
    default:
        {
        index -= 12;

        if (index < this->p_01->getNumParameters())
            return this->p_01->convertFromNormalizedParameterValue(index, value);

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
    default:
        {
        index -= 12;

        if (index < this->p_01->getNumParameters())
            return this->p_01->constrainParameterValue(index, value);

        return value;
        }
    }
}

void processNumMessage(MessageTag tag, MessageTag objectId, MillisecondTime time, number payload) {
    RNBO_UNUSED(objectId);
    this->updateTime(time, (ENGINE*)nullptr);

    switch (tag) {
    case TAG("hit"):
        {
        this->inport_01_value_number_set(payload);
        break;
        }
    }

    this->p_01->processNumMessage(tag, objectId, time, payload);
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
    case TAG("hit"):
        {
        this->inport_01_value_list_set(payload);
        break;
        }
    }

    this->p_01->processListMessage(tag, objectId, time, payload);
}

void processBangMessage(MessageTag tag, MessageTag objectId, MillisecondTime time) {
    RNBO_UNUSED(objectId);
    this->updateTime(time, (ENGINE*)nullptr);

    switch (tag) {
    case TAG("hit"):
        {
        this->inport_01_value_bang_bang();
        break;
        }
    }

    this->p_01->processBangMessage(tag, objectId, time);
}

MessageTagInfo resolveTag(MessageTag tag) const {
    switch (tag) {
    case TAG("hit"):
        {
        return "hit";
        }
    case TAG(""):
        {
        return "";
        }
    }

    auto subpatchResult_0 = this->p_01->resolveTag(tag);

    if (subpatchResult_0)
        return subpatchResult_0;

    return "";
}

MessageIndex getNumMessages() const {
    return 1;
}

const MessageInfo& getMessageInfo(MessageIndex index) const {
    switch (index) {
    case 0:
        {
        static const MessageInfo r0 = {
            "hit",
            Inport
        };

        return r0;
        }
    }

    return NullMessageInfo;
}

protected:

class RNBOSubpatcher_101 : public PatcherInterfaceImpl {
    
    friend class rnbomatic;
    
    public:
    
    RNBOSubpatcher_101()
    {}
    
    ~RNBOSubpatcher_101()
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
    
    RNBOSubpatcher_101* operator->() {
        return this;
    }
    const RNBOSubpatcher_101* operator->() const {
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
}

void initializeObjects() {
    this->p_01->initializeObjects();
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
}

ParameterIndex getParameterOffset(BaseInterface& subpatcher) const {
    if (addressOf(subpatcher) == addressOf(this->p_01))
        return 12;

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

void p_01_perform(SampleValue * out1, SampleValue * out2, Index n) {
    // subpatcher: kick_core
    SampleArray<2> outs = {out1, out2};

    this->p_01->process(nullptr, 0, outs, 2, n);
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
    signal globaltransport_tempo;
    signal globaltransport_state;
    number stackprotect_count;
    Index _voiceIndex;
    Int _noteNumber;
    Index isMuted;
    indexlist paramInitIndices;
    indexlist paramInitOrder;
    RNBOSubpatcher_101 p_01;
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

