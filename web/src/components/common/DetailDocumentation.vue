<template>
    <v-btn variant="text" color="#4a7c59" icon="mdi-arrow-left-thick" @click="$router.back()"></v-btn>
    <div class="title mb-3">
        <h1 class="documentation-name">
            [{{ documentation.category_code }}] {{ documentation.name }}
        </h1>
    </div>
    <div class="content">
        <v-expansion-panels v-model="panel" class="mb-4">
            <v-expansion-panel>
                <v-expansion-panel-title>
                    <strong>Thông tin</strong>
                </v-expansion-panel-title>
                <v-expansion-panel-text>
                    <div class="mb-1">
                        <strong>Kỹ năng:</strong> {{ documentation.skill }}
                    </div>
                    <div class="mb-1">
                        <strong>Mô tả:</strong> {{ documentation.description }}
                    </div>
                </v-expansion-panel-text>
            </v-expansion-panel>
        </v-expansion-panels>
        <v-expansion-panels color="error">
            <v-expansion-panel>
                <slot>
                    <v-expansion-panel-title>
                        <strong>Tài liệu</strong>
                    </v-expansion-panel-title>
                </slot>
                <v-expansion-panel-text v-if="documentation.type === 'vocabulary'">
                    <div v-for="doc in docs">{{ doc }}</div>
                </v-expansion-panel-text>

                <v-expansion-panel-text v-if="documentation.type === 'example'">
                    <v-expansion-panels variant="accordion" v-model="examplePanel">
                        <v-expansion-panel v-for="doc in docs">
                            <v-expansion-panel-title>
                                <strong>Ví dụ</strong>
                            </v-expansion-panel-title>
                            <v-expansion-panel-text>
                                <div v-for="value in doc">{{ value }}</div>
                            </v-expansion-panel-text>
                        </v-expansion-panel>
                    </v-expansion-panels>
                </v-expansion-panel-text>
            </v-expansion-panel>
        </v-expansion-panels>
    </div>
</template>
  
<script setup>
import api from "@/plugins/url";
import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";

const props = defineProps({
    id: String,
    editDoc: { type: String, default: '' }
});

const documentation = ref({});
const docs = ref([]);
const panel = ref([0]);
const examplePanel = ref([0]);

onMounted(() => {
    api.get(`/api/documentations/${props.id}`).then((res) => {
        documentation.value = res.data;
        if (res.data.type === 'vocabulary') docs.value = !!props.editDoc.value ? props.editDoc.value.split(';') : res.data.doc.split(";");
        else {
            docs.value = !!props.editDoc.value ? props.editDoc.value.split(';') : res.data.doc.split("\n\n\n")
            for (const [idx, doc] of docs.value.entries()) {
                docs.value[idx] = doc.split(";")
            }
        }
    });
});
</script>
  
<style scoped></style>