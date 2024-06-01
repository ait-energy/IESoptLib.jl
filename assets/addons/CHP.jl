module Addon_CHP

import IESopt

function build(comp::IESopt._CoreComponent)
    model = comp.model
    linked_unit = IESopt.component(model, comp.config["linked"])

    # Check if linked Unit is already initialized, if not it will be the one to handle everything.
    (linked_unit.init_state[] != :initialized) && return

    # Prepare the "heat" and "power" components (for easy access).
    if occursin("power", comp.name)
        comp_power = comp
        comp_heat = linked_unit
    elseif occursin("heat", comp.name)
        comp_power = linked_unit
        comp_heat = comp
    else
        @error "[Addon_CHP] Encountered unknown heat<>power setup" name = comp.name
        return false
    end

    # Get all needed objects / parameters.
    T = model.ext[:iesopt].model.T
    cm = comp.config["cm"]
    cv = comp.config["cv"]

    # Extract P_max from the "power component"
    if comp_power.capacity_carrier.carrier.name != "electricity"
        @error "[Addon_CHP] Encountered wrong capacity carrier on power unit" carrier =
            comp_power.capacity_carrier.carrier.name
        return false
    end
    p_max = IESopt._get(comp_power.capacity)

    # Construct the backpressure constraint.
    # `c_m \cdot heat_t <= power_t`
    comp.ext["constr_addon_CHP_backpressure"] =
        IESopt.@constraint(model, [t = T], cm * comp_heat.exp.out_heat[t] <= comp_power.exp.out_electricity[t])

    # Construct the isofuel constraint.
    # `power_t <= p_max - c_v \cdot heat_t`
    comp.ext["constr_addon_CHP_isofuel"] =
        IESopt.@constraint(model, [t = T], comp_power.exp.out_electricity[t] <= p_max - cv * comp_heat.exp.out_heat[t])

    @info "[Addon_CHP] Finished constructing constraints"
    return true
end

end
